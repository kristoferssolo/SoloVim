return {
	{ "rcarriga/nvim-dap-ui", event = "VeryLazy", dependencies = "jayp0521/mason-nvim-dap.nvim" },
	{
		"jayp0521/mason-nvim-dap.nvim",
		event = "VeryLazy",
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
		},
	},
	{ "ravenxrz/DAPInstall.nvim", lazy = true },
}
