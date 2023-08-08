return {
	{
		"rcarriga/nvim-dap-ui",
		event = "VeryLazy",
		dependencies = { "jayp0521/mason-nvim-dap.nvim" },
		opts = {
			layouts = {
				{
					elements = {
						"scopes",
						"breakpoints",
						"stacs",
						"watches",
					},
					size = 40,
					position = "left",
				},
				{
					elements = {
						"repl",
						"console",
					},
					size = 10,
					position = "bottom",
				},
			},
			-- sidebar = {
			--     elements = {
			--         {
			--             id = "scopes",
			--             size = 0.25, -- Can be float or integer > 1
			--         },
			--         { id = "breakpoints", size = 0.25 },
			--     },
			--     size = 40,
			--     position = "right", -- Can be "left", "right", "top", "bottom"
			-- },
			-- tray = {
			--     elements = {},
			-- },
		},
	},
	{
		"jayp0521/mason-nvim-dap.nvim",
		event = "VeryLazy",
		dependencies = {
			{
				"williamboman/mason.nvim",
				opts = {
					automatic_installation = true,
					automatic_setup = true,
				},
			},
			"mfussenegger/nvim-dap",
		},
	},
	{ "ravenxrz/DAPInstall.nvim", lazy = true },
}
