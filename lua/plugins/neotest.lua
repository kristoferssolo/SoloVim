return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/neotest-python",
		"alfaix/neotest-gtest",
		"nvim-neotest/neotest-vim-test",
		"mrcjkb/rustaceanvim",
	},
	cmd = { "Neotest" },
	keys = {
		{
			"<leader>tt",
			function()
				require("neotest").watch.toggle(vim.fn.expand("%"))
			end,
			desc = "Toggle Neo[T]est",
		},
		{
			"<leader>ts",
			function()
				require("neotest").summary.toggle()
			end,
			desc = "Toggle [S]ummary",
		},
		{
			"<leader>tj",
			function()
				require("neotest").jump.next({ status = "failed" })
			end,
			desc = "Jump to next",
		},
		{
			"<leader>tk",
			function()
				require("neotest").jump.prev({ status = "failed" })
			end,
			desc = "Jump to prev",
		},
	},
	opts = function(_, opts)
		opts = opts or {}
		opts.adapters = {
			require("neotest-python")({
				dap = { justMyCode = false },
				args = { "--log-level", "DEBUG" },
				runner = "pytest",
			}),
			require("neotest-gtest").setup({}),
			require("neotest-vim-test")({
				ignore_file_types = { "python", "vim", "lua" },
			}),
			require("rustaceanvim.neotest"),
		}
		return opts
	end,
	config = function(_, opts)
		require("neotest").setup(opts)
	end,
}
