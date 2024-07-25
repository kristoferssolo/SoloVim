return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/neotest-python",
		"mrcjkb/rustaceanvim",
		"alfaix/neotest-gtest",
		"nvim-neotest/neotest-vim-test",
	},
	-- enabled = false,
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-python")({
					dap = { justMyCode = false },
					args = { "--log-level", "DEBUG" },
					runner = "pytest",
				}),
				require("rustaceanvim.neotest"),
				require("neotest-gtest").setup({}),
				require("neotest-vim-test")({
					ignore_file_types = { "python", "vim", "lua" },
				}),
			},
		})
	end,
}
