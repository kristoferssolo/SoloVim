return {
	"zerochae/dbab.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim", -- Optional: for async execution
	},
	keys = {
		{
			"<leader>od",
			vim.cmd.Dbab,
			desc = "Toggle Dbab",
		},
	},
	cmd = { "Dbab" },
	opts = {
		connections = {
			{ name = "postgres", url = "postgres://postgres:password@localhost:5432" },
			{ name = "sqlite", url = "sqlite://data/portfolio.db" },
			{ name = "prod", url = "$DATABASE_URL" },
		},
		result = {
			style = "table", -- "table", "json", "raw", "vertical", "markdown"
		},
		sidebar = {
			width = 0.15,
		},
		history = {
			width = 0.15,
		},
	},
}
