return {
	{
		"stevearc/oil.nvim",
		dependencies = {
			{ "echasnovski/mini.icons", version = "*" },
		},
		keys = {
			{
				"-",
				vim.cmd.Oil,
				desc = "Open parent directory",
			},
		},
		version = "*",
		lazy = false,
		opts = {
			columns = {
				"icon",
				"size",
			},
			delete_to_trash = true,
			keymaps = {
				["<C-v>"] = { "actions.select", opts = { vertical = true } },
				["<C-s>"] = { "actions.select", opts = { horizontal = true } },
				["<C-h>"] = {},
				["<C-l>"] = {},
				["t"] = { "actions.select", opts = { tab = true } },
				["<C-q>"] = { "actions.close", mode = "n" },
				["<C-r>"] = "actions.refresh",
				["Y"] = "actions.copy_entry_path",
				["."] = { "actions.toggle_hidden", mode = "n" },
			},
			-- Set to false to disable all of the above keymaps
			use_default_keymaps = true,
			view_options = {
				show_hidden = true,
			},
			float = {
				win_options = {
					winblend = 10,
				},
			},
		},
	},
	{
		"benomahony/oil-git.nvim",
		dependencies = { "stevearc/oil.nvim" },
	},
	{
		"JezerM/oil-lsp-diagnostics.nvim",
		dependencies = { "stevearc/oil.nvim" },
		opts = {},
	},
}
