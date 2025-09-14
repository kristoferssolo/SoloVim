return {
	"nvim-telescope/telescope.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-telescope/telescope-media-files.nvim",
		"nvim-telescope/telescope-symbols.nvim",
		"nvim-telescope/telescope-bibtex.nvim",
		"tsakirist/telescope-lazy.nvim",
		"chip/telescope-software-licenses.nvim",
		"crispgm/telescope-heading.nvim",
		"benfowler/telescope-luasnip.nvim",
		"paopaol/telescope-git-diffs.nvim",
		{ "ThePrimeagen/harpoon", branch = "harpoon2" },
		"nvim-telescope/telescope-frecency.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
		"nosduco/remote-sshfs.nvim",
	},
	keys = {
		{
			"<C-n>",
			require("telescope.builtin").git_files,
			desc = "Telescope git_files",
		},
		{
			"<leader>pf",
			require("telescope.builtin").find_files,
			desc = "Files",
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
		{ "<leader>ps", require("telescope.builtin").live_grep, desc = "Live Grep" },
		{ "<leader>pb", require("telescope.builtin").buffers, desc = "Find Buffers" },
		{ "<leader>pws", require("telescope.builtin").grep_string, desc = "String under the cursor" },
		{ "<leader>pe", require("telescope.builtin").symbols, desc = "Emoji" },
		{ "<leader>pd", require("telescope.builtin").diagnostic, desc = "Diagnostics" },
		{ "<leader>pB", require("telescope.builtin").git_branches, desc = "Checkout Branch" },
		{ "<leader>ph", require("telescope.builtin").help_tags, desc = "Help" },
		{ "<leader>pM", require("telescope.builtin").man_pages, desc = "Man Pages" },
		{ "<leader>pr", require("telescope.builtin").oldfiles, desc = "Open Recent Files" },
		{ "<leader>pR", require("telescope.builtin").registers, desc = "Registers" },
		{ "<leader>pg", require("telescope.builtin").git_files, desc = "Git Files" },
		{ "<leader>pk", require("telescope.builtin").keymaps, desc = "Keymaps" },
		{ "<leader>pC", require("telescope.builtin").commands, desc = "Commands" },
		{ "<leader>pt", vim.cmd.TodoTelescope, desc = "Todo" },
		{
			"<leader>pm",
			function()
				require("telescope").extensions.media_files.media_files()
			end,
			desc = "Media",
		},
		{
			"<leader>pc",
			function()
				require("telescope.builtin").colorscheme({ enable_preview = true })
			end,
			desc = "Colorscheme with Preview",
		},
		{
			"<leader>pl",
			function()
				require("telescope").extensions.lazy.lazy()
			end,
			desc = "Lazy",
		},
		{
			"<leader>pL",
			function()
				require("telescope").extensions.luasnip.luasnip()
			end,
			desc = "Luasnip",
		},
		{
			"<leader>pH",
			function()
				require("telescope").extensions.heading.heading()
			end,
			desc = "Heading",
		},
		{
			"<leader>pds",
			"<cmd>Telescope software-licenses find<cr>",
			desc = "Software Licenses",
		},
		{
			"<leader>pD",
			function()
				require("telescope").extensions.git_diffs.diff_commits()
			end,
			desc = "Git Diff Telescope",
		},
		{
			"<leader>tB",
			require("telescope.builtin").bibtex,
			desc = "Telescope Bibtex",
		},
	},
	opts = {
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
					["<C-D>"] = require("telescope.actions").delete_buffer + require("telescope.actions").move_to_top,
					["<C-t>"] = require("trouble.sources.telescope").open,
					-- ["<C-Y>"] = require("telescope.actions").remove_selection
				},
				n = { ["<C-t>"] = require("trouble.sources.telescope").open },
			},
			history = {
				path = "~/.local/share/nvim/databases/telescope_history.sqlite3",
				limit = 100,
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
			frecency = {
				path_display = { "short" },
				ignore_patterns = { "*/.git/*", "*/.DS_Store/*", "*/.venv/*", "*/tmp/*", "*/bruno/*" },
				default_workspace = "CWD",
				hide_current_buffer = true,
				show_scores = true,
			},
			package_info = {
				-- Optional theme (the extension doesn't set a default theme)
				theme = "ivy",
			},
		},
	},
	config = function(_, opts)
		local telescope = require("telescope")

		telescope.setup(opts)

		pcall(telescope.load_extension, "fzf")
		pcall(telescope.load_extension, "ui-select")
		pcall(telescope.load_extension, "media_files") -- Telescope media_files
		pcall(telescope.load_extension, "lazy") -- Telescope lazy
		pcall(telescope.load_extension, "software-licenses") -- Telescope software-licenses list
		pcall(telescope.load_extension, "heading") -- Telescope heading
		pcall(telescope.load_extension, "luasnip") -- Telescope luasnip
		pcall(telescope.load_extension, "git_diffs") -- Telescope git_diffs diff_commits
		pcall(telescope.load_extension, "bibtex") -- Telescope bibtex
		pcall(telescope.load_extension, "harpoon")
		pcall(telescope.load_extension, "frecency")
		pcall(telescope.load_extension, "remote-sshfs")
	end,
}
