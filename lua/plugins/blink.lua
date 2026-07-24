local function get_mini_icon(ctx)
	if ctx.source_name == "Path" then
		local is_unknown_type = vim.tbl_contains({ "link", "socket", "fifo", "block", "unknown" }, ctx.item.data.type)
		local mini_icon, mini_hl, _ = require("mini.icons").get(
			is_unknown_type and "os" or ctx.item.data.type,
			is_unknown_type and "" or ctx.label
		)
		if mini_icon then
			return mini_icon, mini_hl
		end
	end
	local mini_icon, mini_hl, _ = require("mini.icons").get("lsp", ctx.kind)
	return mini_icon, mini_hl
end

return {
	{
		"saghen/blink.cmp",
		dependencies = {
			"folke/lazydev.nvim",
			{ "echasnovski/mini.icons", version = "*" },
			"barrettruth/blink-cmp-ghostty",
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
				"epwalsh/obsidian.nvim",
				event = "BufReadPre " .. vim.fn.expand("~") .. "/Obsidian/**/*.md",
			},
			{
				"zerochae/dbab.nvim",
				ft = { "sql", "mysql", "plsql" },
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
					"snippets",
					"ripgrep",
					"ghostty",
				},
				per_filetype = {
					sql = { "lsp", "dbab", "buffer", "snippets" },
					mysql = { "lsp", "dbab", "buffer", "snippets" },
					plsql = { "lsp", "dbab", "buffer", "snippets" },
					markdown = { "lsp", "obsidian", "ripgrep", "buffer", "path", "snippets" },
				},
				providers = {
					dbab = {
						name = "dbab",
						module = "blink_dbab",
						score_offset = 100,
					},
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
					snippets = {
						score_offset = -10,
					},
					ghostty = {
						name = "Ghostty",
						module = "blink-cmp-ghostty",
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
									local kind_icon, _, _ = get_mini_icon(ctx)
									return kind_icon
								end,
								-- Optionally, you may also use the highlights from mini.icons
								highlight = function(ctx)
									local _, hl = get_mini_icon(ctx)
									return hl
								end,
							},
							kind = {
								highlight = function(ctx)
									local _, hl = get_mini_icon(ctx)
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
