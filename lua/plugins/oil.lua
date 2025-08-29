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
				-- "permissions",
				"size",
				-- "mtime",
			},
			-- Restore window options to previous values when leaving an oil buffer
			restore_win_options = true,
			-- Skip the confirmation popup for simple operations
			delete_to_trash = true,
			-- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
			-- options with a `callback` (e.g. { callback = function() ... end, desc = "", nowait = true })
			-- Additionally, if it is a string that matches "actions.<name>",
			-- it will use the mapping at require("oil.actions").<name>
			-- Set to `false` to remove a keymap
			-- See :help oil-actions for a list of all available actions
			keymaps = {
				["<C-v>"] = { "actions.select", opts = { vertical = true } },
				["<C-s>"] = { "actions.select", opts = { horizontal = true } },
				["<C-h>"] = {},
				["t"] = { "actions.select", opts = { tab = true } },
				["<C-q>"] = { "actions.close", mode = "n" },
				["<C-r>"] = "actions.refresh",
				["Y"] = "actions.copy_entry_path",
				["."] = { "actions.toggle_hidden", mode = "n" },
			},
			-- Set to false to disable all of the above keymaps
			use_default_keymaps = true,
			view_options = {
				-- Show files and directories that start with "."
				show_hidden = true,
			},
			-- Configuration for the floating window in oil.open_float
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
