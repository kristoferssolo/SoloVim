return {
	{

		"saghen/blink.cmp",
		dependencies = {
			"folke/lazydev.nvim",
			"echasnovski/mini.icons",
			"L3MON4D3/LuaSnip",
			"Saecki/crates.nvim",
			"davidsierradz/cmp-conventionalcommits",
			"petertriho/cmp-git", -- TODO: make this work
			"mikavilpas/blink-ripgrep.nvim",
			{
				"MattiasMTS/cmp-dbee",
				dependencies = {
					{ "kndndrj/nvim-dbee" },
				},
				ft = { "sql", "mysql", "plsql" },
				opts = {},
			},
		},
		version = "*",
		-- build = "cargo build --release", -- build from source

		opts = {
			-- 'default' for mappings similar to built-in completion
			-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
			-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
			-- See the full "keymap" documentation for information on defining your own keymap.
			keymap = {
				preset = "default",
				["<C-e>"] = { "hide", "show", "fallback" },
				["<cr>"] = { "select_and_accept", "fallback" },
				["<C-u>"] = { "scroll_documentation_up", "fallback" },
				["<C-d>"] = { "scroll_documentation_down", "fallback" },
				["<C-g>"] = {
					function()
						require("blink-cmp").show({ sources = { "ripgrep" } })
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
				default = { "lazydev", "crates", "lsp", "path", "luasnip", "buffer", "dbee" },
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
						score_offset = 10,
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
				},
			},
			completion = {
				documentation = { window = { border = "single" }, auto_show = true },
				ghost_text = { enabled = true },
				menu = {
					border = "single",
					auto_show = function(ctx)
						return ctx.mode ~= "cmdline"
					end,
					draw = {
						components = {
							kind_icon = {
								ellipsis = false,
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
			},
			signature = { enabled = true, window = { border = "single" } },
			snippets = {
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
