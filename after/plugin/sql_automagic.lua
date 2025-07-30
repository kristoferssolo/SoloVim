local run_formatter = function(text)
	local split = vim.split(text, "\n")
	local result = table.concat(vim.list_slice(split, 2, #split - 1), "\n")

	local j = require("plenary.job"):new({
		command = "sqruff",
		args = { "format", "-" },
		writer = { result },
	})
	return j:sync()
end
local literals = {
	rust = { "string_literal", "raw_string_literal" },
	python = { "string_content" },
}

local function generate_query(lang, nodes)
	local node_string = table.concat(nodes, ")\n\t\t(")
	local query = string.format(
		[[
	([
		(%s)
	] @sql
		(#match? @sql "(SELECT|select|INSERT|insert|UPDATE|update|DELETE|delete).+(FROM|from|INTO|into|VALUES|values|SET|set).*(WHERE|where|GROUP BY|group by)?")
		(#offset! @sql 1 0 -1 0))
]],
		node_string
	)
	return lang, query
end

local queries = {}
for lang, nodes in pairs(literals) do
	local language, query_string = generate_query(lang, nodes)
	queries[lang] = {
		language = language,
		query = query_string,
	}
end

local get_root = function(bufnr, lang)
	local parser = vim.treesitter.get_parser(bufnr, lang, {})
	local tree = parser:parse()[1]
	return tree:root()
end

local format_dat_sql = function(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()

	local changes = {}
	for _, query in pairs(queries) do
		local root = get_root(bufnr, query.language)
		-- if vim.bo[bufnr].filetype ~= query.language then
		-- 	vim.notify("can only be used in {}", query.language)
		-- 	return
		-- end
		local embedded_sql = vim.treesitter.query.parse(query.language, query.query)
		for id, node in embedded_sql:iter_captures(root, bufnr, 0, -1) do
			local name = embedded_sql.captures[id]
			if name == "sql" then
				-- { start row, start col, end row, end col }
				local range = { node:range() }
				local indentation = string.rep(" ", range[2])

				-- Run the formatter, based on the node text
				local formatted = run_formatter(vim.treesitter.get_node_text(node, bufnr))

				-- Add some indentation (can be anything you like!)
				for idx, line in ipairs(formatted) do
					formatted[idx] = indentation .. line
				end

				-- Keep track of changes
				--    But insert them in reverse order of the file,
				--    so that when we make modifications, we don't have
				--    any out of date line numbers
				table.insert(changes, 1, {
					start = range[1] + 1,
					final = range[3],
					formatted = formatted,
				})
			end
		end
	end

	for _, change in ipairs(changes) do
		vim.api.nvim_buf_set_lines(bufnr, change.start, change.final, false, change.formatted)
	end
end

vim.api.nvim_create_user_command("SqlMagic", function()
	format_dat_sql()
end, {})

local group = vim.api.nvim_create_augroup("rust-sql-magic", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
	group = group,
	pattern = "*.rs",
	callback = function()
		format_dat_sql()
	end,
})
