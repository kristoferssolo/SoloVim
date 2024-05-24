return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/neotest-python",
		"marilari88/neotest-vitest",
		"mrcjkb/rustaceanvim",
		"alfaix/neotest-gtest",
	},
	opts = {
		adapters = {
			["neotest-python"] = {},
			["neotest-vitest"] = {},
			["rustaceanvim.neotest"] = {},
			["neotest-gtest"] = {},
		},
	},
}
