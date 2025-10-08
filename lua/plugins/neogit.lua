return {
	"NeogitOrg/neogit",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"folke/snacks.nvim",
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
	},
	opts = {
		filewatcher = { interval = 500 },
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
