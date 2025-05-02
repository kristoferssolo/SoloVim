return {
	"folke/snacks.nvim",
	dependencies = {
		"echasnovski/mini.icons",
		"stevearc/oil.nvim",
	},
	priority = 1000,
	lazy = false,
	opts = function()
		-- Toggle the profiler
		Snacks.toggle.profiler():map("<leader>sp")
		-- Toggle the profiler highlights
		Snacks.toggle.profiler_highlights():map("<leader>sh")
		return {
			animate = { enabled = false },
			bigfile = { enabled = true },
			bufdelete = { enabled = true },
			dashboard = { enabled = false },
			debug = { enabled = true },
			dim = { enabled = true },
			explorer = { enabled = false },
			git = { enabled = false },
			gitbrowse = { enabled = true },
			image = {
				enabled = true,
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
			picker = { enabled = false },
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
			"<leader>ss",
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
