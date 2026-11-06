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
		{
			"<leader>oD",
			vim.cmd.DBUISelectDatabase,
			desc = "Select database",
		},
	},
	cmd = {
		"DBUI",
		"DBUIToggle",
		"DBUIAddConnection",
		"DBUIFindBuffer",
		"DBUIRefreshClusters",
		"DBUISelectDatabase",
	},
	init = function()
		vim.g.db_ui_use_nerd_fonts = 1
	end,
	config = function()
		require("config.dadbod").setup()
	end,
}
