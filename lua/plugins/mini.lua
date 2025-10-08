return {
	{
		"nvim-mini/mini.diff",
		version = "*",
		event = "VeryLazy",
		keys = {
			{
				"<leader>gd",
				function()
					MiniDiff.toggle_overlay(0)
				end,
				desc = "Git Diff",
			},
		},
		opts = {
			view = {
				style = "sign",
				signs = {
					add = "▎",
					change = "▎",
					delete = "_",
				},
			},
		},
	},
	{
		"nvim-mini/mini.ai",
		version = "*",
		event = "VeryLazy",
		opts = {},
	},
	{
		"nvim-mini/mini.splitjoin",
		version = "*",
		event = "VeryLazy",
		opts = {},
	},
	{
		"nvim-mini/mini.surround",
		version = "*",
		event = "VeryLazy",
		opts = {},
	},
}
