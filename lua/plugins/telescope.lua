return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.5",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-tree/nvim-web-devicons" },
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		{ "nvim-telescope/telescope-media-files.nvim" },
		{ "nvim-telescope/telescope-symbols.nvim" },
		{ "nvim-telescope/telescope-bibtex.nvim" },
		{ "tsakirist/telescope-lazy.nvim" },
		{ "chip/telescope-software-licenses.nvim" },
		{ "barrett-ruth/telescope-http.nvim" },
		{ "crispgm/telescope-heading.nvim" },
		{ "benfowler/telescope-luasnip.nvim" },
		{ "paopaol/telescope-git-diffs.nvim" },
		{ "debugloop/telescope-undo.nvim" },
		{ "ThePrimeagen/harpoon", branch = "harpoon2" },
		{ "ThePrimeagen/git-worktree.nvim" },
	},
	keys = {
		{
			"<C-p>",
			require("telescope.builtin").git_files,
			desc = "Telescope git_files",
		},
		{
			"<leader>pf",
			function()
				require("telescope.builtin").find_files(require("telescope.themes").get_dropdown({ previewer = false }))
			end,
			desc = "[F]iles",
		},
		{
			"<leader>/",
			function()
				require("telescope.builtin").current_buffer_fuzzy_find(
					require("telescope.themes").get_dropdown({ previewer = false })
				)
			end,
			desc = "Current Buffer Fuzzy",
		},
		{
			"<leader>ps",
			require("telescope.builtin").live_grep,
			desc = "Live Grep",
		},
		{
			"<leader>pb",
			require("telescope.builtin").buffers,
			desc = "Find [B]uffers",
		},
		{
			"<leader>pws",
			require("telescope.builtin").grep_string,
			desc = "[S]tring under the cursor",
		},
		{ "<leader>pe", require("telescope.builtin").symbols, desc = "[E]moji" },
		{ "<leader>pd", require("telescope.builtin").diagnostic, desc = "[D]iagnostics" },
		{ "<leader>pB", require("telescope.builtin").git_branches, desc = "Checkout [B]ranch" },
		{ "<leader>ph", require("telescope.builtin").help_tags, desc = "[H]elp" },
		{ "<leader>pM", require("telescope.builtin").man_pages, desc = "[M]an Pages" },
		{ "<leader>pr", require("telescope.builtin").oldfiles, desc = "Open [R]ecent Files" },
		{ "<leader>pR", require("telescope.builtin").registers, desc = "[R]egisters" },
		{ "<leader>pg", require("telescope.builtin").live_grep, desc = "[G]rep" },
		{ "<leader>pG", require("telescope.builtin").git_files, desc = "[G]it Files" },
		{ "<leader>pk", require("telescope.builtin").keymaps, desc = "[K]eymaps" },
		{ "<leader>pC", require("telescope.builtin").commands, desc = "[C]ommands" },
		{ "<leader>pt", vim.cmd.TodoTelescope, desc = "[T]odo" },
		{
			"<leader>pm",
			function()
				require("telescope").extensions.media_files.media_files()
			end,
			desc = "[M]edia",
		},
		{
			"<leader>pc",
			function()
				require("telescope.builtin").colorscheme({ enable_preview = true })
			end,
			desc = "[C]olorscheme with Preview",
		},
		{
			"<leader>pl",
			function()
				require("telescope").extensions.lazy.lazy()
			end,
			desc = "[L]azy",
		},
		{
			"<leader>pL",
			function()
				require("telescope").extensions.luasnip.luasnip()
			end,
			desc = "[L]uasnip",
		},
		{
			"<leader>pH",
			function()
				require("telescope").extensions.heading.heading()
			end,
			desc = "[H]eading",
		},
		{
			"<leader>pDs",
			"<cmd>Telescope software-licenses find<cr>",
			desc = "[S]oftware Licenses",
		},
		{
			"<leader>pDh",
			function()
				require("telescope").extensions.http.list()
			end,
			desc = "[H]TTP",
		},
		{
			"<leader>gw",
			function()
				require("telescope").extensions.git_worktree.git_worktrees()
			end,
			desc = "[G]it Change [W]orktree",
		},
		{
			"<leader>gn",
			function()
				require("telescope").extensions.git_worktree.create_git_worktree()
			end,
			desc = "[G]it Create [N]ew Worktree",
		},
		{
			"<leader>gd",
			function()
				require("telescope").extensions.git_diffs.diff_commits()
			end,
			desc = "[G]it [D]iff",
		},
		{
			"<leader>tB",
			require("telescope.builtin").bibtex,
			desc = "Telescope [B]ibtex",
		},
	},
	config = function()
		local telescope = require("telescope")

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
				file_ignore_patterns = { ".git/", ".spl", "target/", "*.pdf" },
				mappings = {
					i = {
						["<Down>"] = require("telescope.actions").cycle_history_next,
						["<Up>"] = require("telescope.actions").cycle_history_prev,
						["<C-j>"] = require("telescope.actions").move_selection_next,
						["<C-k>"] = require("telescope.actions").move_selection_previous,
						["<C-D>"] = require("telescope.actions").delete_buffer
							+ require("telescope.actions").move_to_top,
						["<c-t>"] = require("trouble").open_with_trouble,
						-- ["<C-Y>"] = require("telescope.actions").remove_selection
					},
					n = { ["<c-t>"] = require("trouble").open_with_trouble },
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
		pcall(telescope.load_extension, "harpoon")
	end,
}
