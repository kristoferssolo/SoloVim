if not pcall(require, "nvim-treesitter") then
	return
end
vim.keymap.set("n", "[d", function()
	vim.diagnostic.goto_next()
	vim.cmd("norm zz")
end, { desc = "Goto next diagnostic" })
vim.keymap.set("n", "]d", function()
	vim.diagnostic.goto_prev()
	vim.cmd("norm zz")
end, { desc = "Goto prev diagnostic" })

require("nvim-treesitter.configs").setup({
	-- A list of parser names, or "all" (the five listed parsers should always be installed)
	ensure_installed = { "cpp", "lua", "rust", "python", "markdown" }, -- one of "all" or a list of languages
	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,
	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = true,
	-- List of parsers to ignore installing (for "all")
	ignore_install = { "latex" },
	modules = {},

	highlight = {
		enable = true,
		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = { "markdown" },

		disable = function(lang, buf)
			local max_filesize = 100 * 1024 -- 100 KB
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return true
			end
		end,
	},
	indent = {
		enable = true,
	},
	autopairs = {
		enable = true,
	},
	autotag = {
		enable = true,
		filetypes = {
			"html",
			"htmldjango",
			"javascript",
			"typescript",
			"javascriptreact",
			"typescriptreact",
			"svelte",
			"vue",
			"tsx",
			"jsx",
			"rescript",
			"xml",
			"php",
			"markdown",
			"glimmer",
			"handlebars",
			"hbs",
		},
	},
	-- incremenral_selection = {
	-- 	enable = true,
	-- 	keymaps = {
	-- 		init_selection = "<C-space>",
	-- 		node_selection = "<C-space>",
	-- 		scope_selection = "<C-space>",
	-- 		node_deselection = "<C-backspace>",
	-- 	},
	-- },
	rainbow = {
		enable = true,
		-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = nil, -- Do not enable for files with more than n lines, int
		-- colors = {}, -- table of hex strings
		-- termcolors = {}, -- table of colour name strings
	},
})
