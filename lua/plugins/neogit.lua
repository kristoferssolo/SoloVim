return {
	"NeogitOrg/neogit",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"sindrets/diffview.nvim", -- Diff integration
		"nvim-telescope/telescope.nvim",
	},
	cmd = { "Neogit" },
	keys = {
		{
			"<leader>gg",
			function()
				require("neogit").open({ kind = "split" })
			end,
			desc = "Git",
		},
		{ "<leader>gd", vim.cmd.DiffviewOpen, desc = "Git Diff" },
	},
	opts = {
		-- When enabled, will watch the `.git/` directory for changes and refresh the status buffer in response to filesystem
		-- events.
		filewatcher = {
			interval = 500,
		},
		-- Allows a different telescope sorter. Defaults to 'fuzzy_with_index_bias'. The example below will use the native fzf
		-- sorter instead. By default, this function returns `nil`.
		telescope_sorter = function()
			return require("telescope").extensions.fzf.native_fzf_sorter()
		end,
		-- Table of settings to never persist. Uses format "Filetype--cli-value"
		ignored_settings = {
			"NeogitPushPopup--force-with-lease",
			"NeogitPushPopup--force",
			"NeogitPullPopup--rebase",
			"NeogitCommitPopup--allow-empty",
			"NeogitRevertPopup--no-edit",
		},
		-- Disable line numbers and relative line numbers
		disable_line_numbers = false,
		-- The time after which an output console is shown for slow running commands
		console_timeout = 1000,
		-- Automatically show console if a command takes more than console_timeout milliseconds
		commit_editor = {
			kind = "auto",
		},
		commit_select_view = {
			kind = "tab",
			show_staged_diff = true,
			-- Accepted values:
			-- "split" to show the staged diff below the commit editor
			-- "vsplit" to show it to the right
			-- "split_above" Like :top split
			-- "vsplit_left" like :vsplit, but open to the left
			-- "auto" "vsplit" if window would have 80 cols, otherwise "split"
			staged_diff_split_kind = "split",
			spell_check = true,
		},
		merge_editor = {
			kind = "tab",
		},
		preview_buffer = {
			kind = "split",
		},
		sections = {
			-- Reverting/Cherry Picking
			stashes = {
				folded = true,
				hidden = false,
			},
		},
		mappings = {
			finder = {
				["q"] = "Close",
			},
		},
	},
}
