return {
	"jmbuhr/otter.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
	enabled = false,
	keys = {
		{
			"<leader>Ot",
			function()
				require("otter").open()
			end,
			desc = "Open Otter",
		},
		{
			"<leader>Oc",
			function()
				require("otter").close()
			end,
			desc = "Close Otter",
		},
	},
	opts = {},
}
