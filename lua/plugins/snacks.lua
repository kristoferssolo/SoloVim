return {
	"folke/snacks.nvim",
	dependencies = {
		{ "echasnovski/mini.icons", version = "*" },
		"stevearc/oil.nvim",
		"folke/trouble.nvim",
		"folke/todo-comments.nvim",
	},
	priority = 1000,
	lazy = false,
	opts = function()
		-- Toggle the profiler
		Snacks.toggle.profiler():map("<leader>Sp")
		-- Toggle the profiler highlights
		Snacks.toggle.profiler_highlights():map("<leader>Sh")
		return {
			animate = { enabled = false },
			bigfile = { enabled = true },
			bufdelete = { enabled = true },
			dashboard = { enabled = false },
			debug = { enabled = true },
			dim = { enabled = false },
			explorer = { enabled = false },
			git = { enabled = true },
			gitbrowse = { enabled = true },
			image = {
				enabled = false,
				doc = {
					inline = false,
					float = true,
				},
				img_dirs = { "img", "images", "assets", "assets/img", "static", "public", "media", "attachments" },
				math = { enabled = false },
			},
			indent = {
				enabled = true,
				animate = { enabled = false },
			},
			input = { enabled = false },
			layout = { enabled = false },
			lazygit = { enabled = false },
			notifier = { enabled = false },
			notify = { enabled = false },
			picker = {
				enabled = true,
				format = "file",
				layout = {
					cycle = true,
					preset = function()
						return vim.o.columns >= 120 and "telescope" or "vertical"
					end,
				},
				matcher = {
					frecency = true,
					cwd_bonus = true,
				},
				actions = require("trouble.sources.snacks").actions,
				win = {
					input = {
						keys = {
							["<C-t>"] = {
								"trouble_open",
								mode = { "n", "i" },
							},
						},
					},
				},
			},
			profiler = { enabled = false },
			quickfile = { enabled = true, exclude = { "latex" } },
			rename = { enabled = true },
			scope = { enabled = false },
			scratch = { enabled = false },
			scroll = { enabled = false },
			statuscolumn = {
				enabled = true,
				left = { "mark", "sign", "git" },
				right = { "fold" },
				folds = {
					open = true, -- show open fold icons
					git_hl = true, -- use Git Signs hl for fold icons
				},
			},
			terminal = { enabled = false },
			toggle = { enabled = true },
			win = { enabled = false },
			words = { enabled = true },
			zen = { enabled = false },
		}
	end,
	keys = {
		{
			"<leader>Nn",
			function()
				Snacks.notifier.show_history()
			end,
			desc = "History",
		},
		{
			"<leader>Ss",
			function()
				Snacks.profiler.scratch()
			end,
			desc = "Profiler Scratch Bufer",
		},
		{
			"<leader>gB",
			function()
				Snacks.gitbrowse()
			end,
			desc = "Git Browse",
		},

		{
			"<leader>gb",
			function()
				Snacks.git.blame_line()
			end,
			desc = "Git Blame",
		},
		{
			"<C-n>",
			function()
				Snacks.picker.files({
					hidden = true,
				})
			end,
			desc = "Find Files",
		},
		{
			"<leader>pf",
			function()
				Snacks.picker.files({
					hidden = true,
					ignored = true,
				})
			end,
			desc = "Find Files",
		},
		{
			"<leader>ps",
			function()
				Snacks.picker.grep({
					hidden = true,
				})
			end,
			desc = "Grep",
		},
		{
			"<leader>pb",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Buffers",
		},
		{
			"<leader>pw",
			function()
				Snacks.picker.grep_word()
			end,
			desc = "Visual selection of word",
			mode = { "n", "x" },
		},
		{
			"<leader>pi",
			function()
				Snacks.picker.icons()
			end,
			desc = "Icons",
		},
		{
			"<leader>ph",
			function()
				Snacks.picker.help()
			end,
			desc = "Help Pages",
		},
		{
			"<leader>pr",
			function()
				Snacks.picker.recent()
			end,
			desc = "Recent",
		},
		{
			"<leader>pR",
			function()
				Snacks.picker.registers()
			end,
			desc = "Registers",
		},
		{
			"<leader>pg",
			function()
				Snacks.picker.git_files()
			end,
			desc = "Find Git Fiels",
		},
		{
			"<leader>pk",
			function()
				Snacks.picker.keymaps()
			end,
			desc = "Keymaps",
		},
		{
			"<leader>pt",
			function()
				Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } })
			end,
			desc = "Todo/Fix/Fixme",
		},
		{
			"<leader>pc",
			function()
				Snacks.picker.colorschemes()
			end,
			desc = "Colorschemes",
		},
		{
			"<leader>pl",
			function()
				Snacks.picker.lazy()
			end,
			desc = "Search for Plugin Spec",
		},
		{
			"<leader>pD",
			function()
				Snacks.picker.diagnostics()
			end,
			desc = "Diagnostics",
		},
	},
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				-- Setup some globals for debugging (lazy-loaded)
				_G.dd = function(...)
					Snacks.debug.inspect(...)
				end
				_G.bt = function()
					Snacks.debug.backtrace()
				end
				vim.print = _G.dd -- Override print to use snacks for `:=` command
			end,
		})
		vim.api.nvim_create_autocmd("User", {
			pattern = "OilActionsPost",
			callback = function(event)
				if event.data.actions.type == "move" then
					Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
				end
			end,
		})
	end,
}
