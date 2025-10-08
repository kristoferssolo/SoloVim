return {
	"stevearc/aerial.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	cmd = {
		"AerialToggle",
		"AerialOpen",
		"AerialOpenAll",
		"AerialClose",
		"AerialCloseAll",
		"AerialNext",
		"AerialPrev",
		"AerialGo",
		"AerialInfo",
		"AerialNavToggle",
		"AerialNavOpen",
		"AerialNavClose",
	},
	keys = {
		{ "<leader>b", vim.cmd.AerialToggle, desc = "Toggle Tagbar" },
	},
	opts = {
		layout = {
			default_direction = "right",
			min_width = { 30, 0.1 },
		},
	},
}
