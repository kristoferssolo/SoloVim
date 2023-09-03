if not pcall(require, "telescope") then
	return
end

vim.keymap.set("n", "<C-p>", require("telescope.builtin").git_files, {})

local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
	defaults = {
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
			"--hidden",
		},
		prompt_prefix = " ",
		selection_caret = " ",
		path_display = { "smart" },
		file_ignore_patterns = { ".git/", ".spl", "target/" },
		mappings = {
			i = {
				["<Down>"] = actions.cycle_history_next,
				["<Up>"] = actions.cycle_history_prev,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<C-D>"] = actions.delete_buffer + actions.move_to_top,
				-- ["<C-Y>"] = actions.remove_selection
			},
		},
	},
	pickers = {
		find_files = {
			hidden = true,
			follow = true,
		},
	},
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
		},
		media_files = {
			-- filetypes whitelist
			filetypes = { "png", "webp", "jpg", "jpeg", "mp4", "webm" },
			find_cmd = "rg",
		},
		emoji = {
			action = function(emoji)
				-- argument emoji is a table.
				-- {name="", value="", cagegory="", description=""}

				vim.fn.setreg("*", emoji.value)
				print([[Press p or "*p to paste this emoji]] .. emoji.value)

				-- insert emoji when picked
				-- vim.api.nvim_put({ emoji.value }, 'c', false, true)
			end,
		},
		["ui-select"] = {
			require("telescope.themes").get_dropdown({
				-- even more opts
			}),

			-- pseudo code / specification for writing custom displays, like the one
			-- for "codeactions"
			-- specific_opts = {
			--   [kind] = {
			--     make_indexed = function(items) -> indexed_items, width,
			--     make_displayer = function(widths) -> displayer
			--     make_display = function(displayer) -> function(e)
			--     make_ordinal = function(e) -> string
			--   },
			--   -- for example to disable the custom builtin "codeactions" display
			--      do the following
			--   codeactions = false,
			-- }
		},
		lazy = {
			-- Optional theme (the extension doesn't set a default theme)
			theme = "dropdown",
			previewer = false,
			-- Whether or not to show the icon in the first column
			show_icon = true,
			-- Mappings for the actions
			mappings = {
				open_in_browser = "<C-o>",
				open_in_file_browser = "<M-b>",
				open_in_find_files = "<C-f>",
				open_in_live_grep = "<C-g>",
				open_plugins_picker = "<C-b>", -- Works only after having called first another action
				open_lazy_root_find_files = "<C-r>f",
				open_lazy_root_live_grep = "<C-r>g",
			},
			-- Other telescope configuration options
		},
		http = {
			-- How the mozilla url is opened. By default will be configured based on OS:
			open_url = "xdg-open %s", -- UNIX
			-- open_url = 'open %s' -- OSX
			-- open_url = 'start %s' -- Windows
		},
		heading = {
			treesitter = true,
			picker_opts = {
				layout_config = { width = 0.8, preview_width = 0.5 },
				layout_strategy = "horizontal",
			},
		},
		bibtex = {
			-- Depth for the *.bib file
			depth = 1,
			-- Custom format for citation label
			custom_formats = {},
			-- Format to use for citation label.
			-- Try to match the filetype by default, or use 'plain'
			format = "",
			-- Path to global bibliographies (placed outside of the project)
			global_files = {},
			-- Define the search keys to use in the picker
			search_keys = { "author", "year", "title" },
			-- Template for the formatted citation
			citation_format = "{{author}} ({{year}}), {{title}}.",
			-- Only use initials for the authors first name
			citation_trim_firstname = true,
			-- Max number of authors to write in the formatted citation
			-- following authors will be replaced by "et al."
			citation_max_auth = 2,
			-- Context awareness disabled by default
			context = false,
			-- Fallback to global/directory .bib files if context not found
			-- This setting has no effect if context = false
			context_fallback = true,
			-- Wrapping in the preview window is disabled by default
			wrap = false,
		},
		undo = {
			use_delta = true,
			use_custom_command = nil, -- setting this implies `use_delta = false`. Accepted format is: { "bash", "-c", "echo '$DIFF' | delta" }
			side_by_side = false,
			diff_context_lines = vim.o.scrolloff,
			entry_format = "state #$ID, $STAT, $TIME",
			time_format = "",
			mappings = {
				i = {
					-- IMPORTANT: Note that telescope-undo must be available when telescope is configured if
					-- you want to replicate these defaults and use the following actions. This means
					-- installing as a dependency of telescope in it's `requirements` and loading this
					-- extension from there instead of having the separate plugin definition as outlined
					-- above.
					["<cr>"] = require("telescope-undo.actions").yank_additions,
					["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
					["<C-cr>"] = require("telescope-undo.actions").restore,
				},
			},
		},
	},
})

pcall(telescope.load_extension, "fzf")
pcall(telescope.load_extension, "media_files") -- Telescope media_files
pcall(telescope.load_extension, "git_worktree") -- Telescope git_worktree
pcall(telescope.load_extension, "lazy") -- Telescope lazy
pcall(telescope.load_extension, "software-licenses") -- Telescope software-licenses list
pcall(telescope.load_extension, "http") -- Telescope http list
pcall(telescope.load_extension, "heading") -- Telescope heading
pcall(telescope.load_extension, "luasnip") -- Telescope luasnip
pcall(telescope.load_extension, "git_diffs") -- Telescope git_diffs diff_commits
pcall(telescope.load_extension, "bibtex") -- Telescope bibtex
pcall(telescope.load_extension, "undo") -- Telescope undo
