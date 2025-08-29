return {
	{
		"kiyoon/jupynium.nvim",
		-- enabled = false,
		dependencies = {
			-- "rcarriga/nvim-notify", -- optional
			-- "stevearc/dressing.nvim", -- optional, UI for :JupyniumKernelSelect
		},
		build = "uv pip install .",
		event = "BufReadPre *.ju.py",
		opts = {
			-- python_host = { "uvx", "jupynium", "python" },
		},
		config = function(_, opts)
			require("jupynium").setup(opts)
			require("jupynium").get_folds()
		end,
	},
	{
		"goerz/jupytext.nvim",
		build = "uv tool install jupytext",
		version = "0.2.0",
		opts = {},
	},
}
