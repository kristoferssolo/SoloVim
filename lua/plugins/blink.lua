return {
	{
		"saghen/blink.cmp",
		dependencies = {
			"folke/lazydev.nvim",
			"echasnovski/mini.icons",
			{ "L3MON4D3/LuaSnip", version = "v2.*" },
			{
				"Saecki/crates.nvim",
				event = { "BufRead Cargo.toml" },
			},
			{
				"Kaiser-Yang/blink-cmp-git",
				dependencies = { "nvim-lua/plenary.nvim" },
			},
			"mikavilpas/blink-ripgrep.nvim",
			"moyiz/blink-emoji.nvim",
			{
				"MattiasMTS/cmp-dbee",
				dependencies = {
					"kndndrj/nvim-dbee",
				},
				ft = { "sql", "mysql", "plsql" },
				opts = {},
			},
			{
				"epwalsh/obsidian.nvim",
				event = "BufReadPre " .. vim.fn.expand("~") .. "/Obsidian/**/*.md",
			},
			{
				"kiyoon/jupynium.nvim",
				event = "BufReadPre *.ju.py",
			},
		},
		version = "*",
		opts = {
			-- "default" for mappings similar to built-in completion
			-- "super-tab" for mappings similar to vscode (tab to accept, arrow keys to navigate)
			-- "enter" for mappings similar to 'super-tab' but with 'enter' to accept
			-- See the full "keymap" documentation for information on defining your own keymap.
			keymap = {
				preset = "default",
				["<C-e>"] = { "hide", "show", "fallback" },
				["<cr>"] = { "select_and_accept", "fallback" },
				["<C-u>"] = {
					function(cmp)
						cmp.scroll_documentation_up(4)
					end,
				},
				["<C-d>"] = {
					function(cmp)
						cmp.scroll_documentation_down(4)
					end,
				},
				["<Tab>"] = {},
				["<S-Tab>"] = {},
			},

			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},

			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				default = {
					"git",
					"lazydev",
					"crates",
					"lsp",
					"path",
					"buffer",
					"dbee",
					"snippets",
					"ripgrep",
					"obsidian",
					-- "markdown",
					"jupynium",
				},
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},
					crates = {
						name = "crates",
						module = "blink.compat.source",
						score_offset = 10,
					},
					dbee = {
						name = "cmp-dbee",
						module = "blink.compat.source",
						score_offset = 50,
					},
					obsidian = {
						name = "obsidian",
						module = "blink.compat.source",
						score_offset = 10,
					},
					-- markdown = {
					-- 	name = "RenderMarkdown",
					-- 	module = "render-markdown.integ.blink",
					-- 	score_offset = 10,
					-- 	fallbacks = { "lsp" },
					-- },
					ripgrep = {
						module = "blink-ripgrep",
						name = "Ripgrep",
						opts = {
							prefix_min_len = 3,
							context_size = 5,
							max_filesize = "1M",
							project_root_marker = { ".git", "package.json", ".root" },
							search_casing = "--smart-case",
							additional_rg_options = {},
							fallback_to_regex_highlighting = true,
						},
					},
					emoji = {
						module = "blink-emoji",
						name = "Emoji",
						score_offset = 15,
						opts = { insert = true },
					},
					jupynium = {
						name = "jupynium",
						module = "blink.compat.source",
						score_offset = 1000,
					},
					git = {
						score_offset = 100,
						module = "blink-cmp-git",
						name = "Git",
						enabled = true,
						should_show_items = function()
							return vim.o.filetype == "gitcommit" or vim.o.filetype == "markdown"
						end,
						opts = {},
					},
				},
			},
			completion = {
				-- 'prefix' will fuzzy match on the text before the cursor
				-- 'full' will fuzzy match on the text before *and* after the cursor
				-- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
				keyword = { range = "full" },
				-- Disable auto brackets
				-- NOTE: some LSPs may add auto brackets themselves anyway
				accept = { auto_brackets = { enabled = true } },
				-- Insert completion item on selection, don't select by default
				-- list = { selection = "auto_insert" },
				trigger = {
					prefetch_on_insert = false,
				},
				list = {
					selection = {
						preselect = function(ctx)
							return ctx.mode ~= "cmdline"
						end,
						auto_insert = function(ctx)
							return ctx.mode ~= "cmdline"
						end,
					},
				},
				menu = {
					auto_show = function(ctx)
						return ctx.mode ~= "cmdline"
					end,
					border = "single",
					draw = {
						columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "kind" } },
						components = {
							kind_icon = {
								ellipsis = true,
								text = function(ctx)
									local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
									return kind_icon
								end,
								-- Optionally, you may also use the highlights from mini.icons
								highlight = function(ctx)
									local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
									return hl
								end,
							},
						},
					},
				},
				documentation = { window = { border = "single" }, auto_show = true },
				ghost_text = { enabled = true },
			},
			signature = { enabled = true, window = { border = "single" } },
			snippets = {
				preset = "luasnip",
				expand = function(snippet)
					require("luasnip").lsp_expand(snippet)
				end,
				active = function(filter)
					if filter and filter.direction then
						return require("luasnip").jumpable(filter.direction)
					end
					return require("luasnip").in_snippet()
				end,
				jump = function(direction)
					require("luasnip").jump(direction)
				end,
			},
		},
		opts_extend = { "sources.default" },
	},
	{
		"saghen/blink.compat",
		version = "*",
		lazy = true,
		opts = {},
	},
}
