local detail = false

function _G.get_oil_winbar()
	local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
	local dir = require("oil").get_current_dir(bufnr)
	if dir then
		return vim.fn.fnamemodify(dir, ":~")
	else
		return vim.api.nvim_buf_get_name(0)
	end
end

return {
	{
		"stevearc/oil.nvim",
		dependencies = {
			{ "echasnovski/mini.icons", version = "*", opts = {} },
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
			win_options = {
				winbar = "%!v:lua.get_oil_winbar()",
			},
			delete_to_trash = true,
			skip_confirm_for_simple_edits = true,
			watch_for_changes = true,
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
				["gd"] = {
					desc = "Toggle file detail view",
					callback = function()
						detail = not detail
						if detail then
							require("oil").set_columns({ "icon", "size", "permissions", "mtime" })
						else
							require("oil").set_columns({ "icon", "size" })
						end
					end,
				},
			},
			-- Set to false to disable all of the default keymaps
			use_default_keymaps = true,
			view_options = {
				show_hidden = true,
			},
			float = { border = "rounded" },
			confirmation = {
				win_options = {
					winblend = 10,
				},
				border = "rounded",
			},
			progress = { border = "rounded" },
			ssh = { border = "rounded" },
			keymaps_help = { border = "rounded" },
		},
	},
	{
		"malewicz1337/oil-git.nvim",
		dependencies = { "stevearc/oil.nvim" },
		opts = {
			show_file_highlights = true,
			show_directory_highlights = false,
			show_ignored_files = true,
		},
	},
	{
		"JezerM/oil-lsp-diagnostics.nvim",
		dependencies = { "stevearc/oil.nvim" },
		opts = {},
	},
}
