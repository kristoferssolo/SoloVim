return {
	"kristijanhusak/vim-dadbod-ui",
	dependencies = {
		{ "tpope/vim-dadbod", lazy = true },
		{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true }, -- Optional
		{ "tpope/vim-dotenv" },
	},
	keys = {
		{
			"<leader>od",
			vim.cmd.DBUIToggle,
			desc = "Toggle DBUI",
		},
	},
	cmd = {
		"DBUI",
		"DBUIToggle",
		"DBUIAddConnection",
		"DBUIFindBuffer",
	},
	config = function()
		vim.g.db_ui_use_nerd_fonts = 1
		local connections = {
			dev = vim.fn.DotenvGet("DATABASE_URL"),
		}
		local local_connections = vim.fn.stdpath("config") .. "/dadbod.local.lua"
		if vim.fn.filereadable(local_connections) == 1 then
			connections = vim.tbl_extend("force", connections, dofile(local_connections))
		end
		local names = vim.tbl_keys(connections)
		table.sort(names, function(a, b)
			if a == "dev" then
				return b ~= "dev"
			end
			if b == "dev" then
				return false
			end
			return a < b
		end)
		local ordered_connections = {}
		for _, name in ipairs(names) do
			table.insert(ordered_connections, { name = name, url = connections[name] })
		end
		vim.g.dbs = ordered_connections
	end,
}
