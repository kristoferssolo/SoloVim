return {
	{
		"tadmccorkle/markdown.nvim",
		ft = { "markdown" },
		opts = {},
	},
	{
		"OXY2DEV/markview.nvim",
		dependencies = {
			"saghen/blink.cmp",
			{ "echasnovski/mini.icons", version = "*" },
		},
		ft = { "markdown" },
		lazy = false,
		keys = {
			{
				"<C-Space>",
				function()
					vim.cmd("Checkbox toggle")
				end,
			},
			{
				">>",
				function()
					vim.cmd("HeadingIncrease")
				end,
			},
			{
				"<<",
				function()
					vim.cmd("HeadingDecrease")
				end,
			},
		},
		opts = {
			preview = {
				icon_provider = "mini",
				hybrid_modes = { "i", "n" },
				debounce = 50,
			},
			cursor_line = {
				disable_rendering = true,
			},
			linewise_hybrid_mode = true,
			markdown = {
				enable = true,
				math = {
					engine = "typst", -- Use Typst engine for math rendering
					inline = true, -- Enable for inline math
					blocks = true, -- Enable for math blocks
				},
			},
			latex = { enable = false },
			typst = { enable = false },
			html = { enable = false },
		},
		config = function(_, opts)
			require("markview").setup(opts)
			require("markview.extras.checkboxes").setup(opts.checkboxes)
			require("markview.extras.headings").setup()
			require("markview.extras.editor").setup()
		end,
	},
}
