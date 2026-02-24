return {
	"zerochae/dbab.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim", -- Optional: for async execution
		-- "tpope/vim-dadbod", -- Optional: for executor = "dadbod"
	},
	keys = {
		{
			"<leader>od",
			-- require("dbab").toggle,
			desc = "Toggle Dbab",
		},
	},
	cmd = { "Dbab" },
	opts = {
		-- executor = "dadbod",
		connections = {
			{ name = "newsletter", url = "postgres://postgres:password@localhost:5432/newsletter?sslmode=disable" },
			{
				name = "maze_ascension",
				url = "postgres://postgres:password@localhost:5432/maze_ascension?sslmode=disable",
			},
			{ name = "prod", url = "$DATABASE_URL" }, -- supports env vars
		},
	},
}
