return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-neotest/neotest-python",
		"alfaix/neotest-gtest",
		"mrcjkb/rustaceanvim",
	},
	cmd = "Neotest",
	keys = {
		{
			"<leader>tt",
			function()
				require("neotest").watch.toggle(vim.fn.expand("%"))
			end,
			desc = "Watch current test file",
		},
		{
			"<leader>ts",
			function()
				require("neotest").summary.toggle()
			end,
			desc = "Toggle test summary",
		},
		{
			"<leader>tj",
			function()
				require("neotest").jump.next({ status = "failed" })
			end,
			desc = "Next failed test",
		},
		{
			"<leader>tk",
			function()
				require("neotest").jump.prev({ status = "failed" })
			end,
			desc = "Previous failed test",
		},
	},
	opts = function()
		return {
			adapters = {
				require("neotest-python")({
					dap = { justMyCode = false },
					runner = "pytest",
				}),
				require("neotest-gtest").setup({}),
				require("rustaceanvim.neotest"),
			},
		}
	end,
}
