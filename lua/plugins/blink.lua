return {
	{
		"saghen/blink.cmp",
		dependencies = {
			"folke/lazydev.nvim",
			"echasnovski/mini.icons",
			"jdrupal-dev/css-vars.nvim",
			"xzbdmw/colorful-menu.nvim",
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
			"supermaven-inc/supermaven-nvim",
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
					"snippets",
					"ripgrep",
					"jupynium",
					"css_vars",
				},
				per_filetype = {
					sql = { "dbee", "buffer", "snippets" },
					musql = { "dbee", "buffer", "snippets" },
					plsql = { "dbee", "buffer", "snippets" },
					markdown = { "lsp", "obsidian", "ripgrep", "buffer", "path", "snippets", "supermaven" },
				},
				providers = {
					buffer = {
						score_offset = -50,
						opts = {
							prefix_min_len = 3,
						},
					},
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
					supermaven = {
						name = "supermaven",
						module = "blink.compat.source",
						score_offset = 10,
					},
					ripgrep = {
						module = "blink-ripgrep",
						name = "Ripgrep",
						score_offset = -100,
						opts = {
							prefix_min_len = 5,
							project_root_marker = { ".git", "package.json", ".root" },
							fallback_to_regex_highlighting = true,
							backend = {
								ripgrep = {
									context_size = 5,
									max_filesize = "1M",
									search_casing = "--smart-case",
									additional_rg_options = {},
								},
							},
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
						score_offset = 100,
					},
					git = {
						score_offset = 100,
						module = "blink-cmp-git",
						name = "Git",
						enabled = true,
						should_show_items = function()
							return vim.o.filetype == "gitcommit"
						end,
						opts = {},
					},
					css_vars = {
						name = "css-vars",
						module = "css-vars.blink",
						opts = {
							-- WARNING: The search is not optimized to look for variables in JS files.
							-- If you change the search_extensions you might get false positives and weird completion results.
							search_extensions = { ".js", ".ts", ".jsx", ".tsx" },
						},
					},
					snippets = {
						score_offset = -10,
					},
				},
			},
			cmdline = {
				enabled = false,
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
						preselect = true,
						auto_insert = true,
					},
				},
				menu = {
					auto_show = true,
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
							label = {
								text = function(ctx)
									return require("colorful-menu").blink_components_text(ctx)
								end,
								highlight = function(ctx)
									return require("colorful-menu").blink_components_highlight(ctx)
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
