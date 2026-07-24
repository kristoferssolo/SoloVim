return {
	{
		"nvim-mini/mini.ai",
		version = "*",
		opts = {},
	},
	{
		"nvim-mini/mini.comment",
		version = "*",
		opts = {},
	},
	{
		"nvim-mini/mini.move",
		version = "*",
		opts = {},
	},
	{
		"nvim-mini/mini.pairs",
		version = "*",
		opts = {},
	},
	{
		"nvim-mini/mini.splitjoin",
		version = "*",
		opts = {},
	},
	{
		"nvim-mini/mini.surround",
		version = "*",
		opts = {},
	},
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
}
