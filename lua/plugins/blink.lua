return {
	{
		"saghen/blink.cmp",
		dependencies = {
			"folke/lazydev.nvim",
			"echasnovski/mini.icons",
			{ "L3MON4D3/LuaSnip", version = "v2.*" },
			"Saecki/crates.nvim",
			"davidsierradz/cmp-conventionalcommits",
			"petertriho/cmp-git", -- TODO: make this work
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
				"petertriho/cmp-git",
				ft = { "gitcommit", "octo", "NeogitCommitMessage" },
			},
		},
		version = "*",
		-- build = "cargo build --release", -- build from source

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
				["<C-g>"] = {
					function()
						require("blink-cmp").show({ sources = { "ripgrep" } })
					end,
					"fallback",
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
					"lazydev",
					"crates",
					"lsp",
					"path",
					"buffer",
					"git",
					"dbee",
					"snippets",
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
					git = {
						name = "git",
						module = "blink.compat.source",
						score_offset = 20,
					},
					dbee = {
						name = "cmp-dbee",
						module = "blink.compat.source",
						score_offset = 50,
					},
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
						score_offset = 100,
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
