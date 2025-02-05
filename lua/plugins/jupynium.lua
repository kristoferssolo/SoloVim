return {
	{
		"kiyoon/jupynium.nvim",
		dependencies = {
			"rcarriga/nvim-notify", -- optional
			-- "stevearc/dressing.nvim", -- optional, UI for :JupyniumKernelSelect
		},
		build = "uv tool install .",
		event = "BufReadPre *.ju.py",
		opts = {
			python_host = { "uvx", "jupynium", "python" },
		},
		config = function(_, opts)
			require("jupynium").setup(opts)
			require("jupynium").get_folds()
		end,
	},
	{
		"goerz/jupytext.nvim",
		version = "*",
		opts = {},
	},
}
