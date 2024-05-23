return {
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
		"hrsh7th/cmp-buffer", -- buffer completions
		"hrsh7th/cmp-cmdline",
		"FelipeLema/cmp-async-path", -- path completions
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-nvim-lsp",
		{ "Saecki/crates.nvim", event = { "BufRead Cargo.toml" } },
		{
			"vrslev/cmp-pypi",
			dependencies = { "nvim-lua/plenary.nvim" },
			event = { "BufRead pyproject.toml", "BufRead requirements.txt", "BufRead requirements_dev.txt" },
		},
		{ "kristijanhusak/vim-dadbod-completion", dependencies = { "tpope/vim-dadbod" } },
		"SergioRibera/cmp-dotenv",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-calc",
		"Exafunction/codeium.nvim",
		"petertriho/cmp-git",
		"davidsierradz/cmp-conventionalcommits",
		"ryo33/nvim-cmp-rust",
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local compare = require("cmp.config.compare")
		local kind_icons = {
			Text = "󰉿",
			Method = "󰆧",
			Function = "󰊕",
			Constructor = "",
			Field = "󰜢",
			Variable = "󰀫",
			Class = "󰠱",
			Interface = "",
			Module = "",
			Property = "󰜢",
			Unit = "󰑭",
			Value = "󰎠",
			Enum = "",
			Keyword = "󰌋",
			Snippet = "",
			Color = "󰏘",
			File = "󰈙",
			Reference = "󰈇",
			Folder = "󰉋",
			EnumMember = "",
			Constant = "󰏿",
			Struct = "󰙅",
			Event = "",
			Operator = "󰆕",
			TypeParameter = "",
			Copilot = "",
			Codeium = "",
		}

		cmp.setup({
			mapping = {
				["<C-p>"] = cmp.mapping.select_prev_item({behavior=cmp.SelectBehavior.Insert}),
				["<C-n>"] = cmp.mapping.select_next_item({behavior=cmp.SelectBehavior.Insert}),
				["<C-d>"] = cmp.mapping.scroll_docs(-4),
				["<C-u>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping({
					i = cmp.mapping.abort(),
					c = cmp.mapping.close(),
				}),
				-- Accept currently selected item. If none selected, `select` first item.
				-- Set `select` to `false` to only confirm explicitly selected items.
				["<CR>"] = cmp.mapping.confirm({ select = true }),
			},
			sources = {
				{ name = "nvim_lua" },
				{ name = "nvim_lsp" },
				{ name = "crates" },
				{ name = "async_path" },
				{ name = "luasnip" },
				{ name = "buffer", keyword_length = 4 },
				{ name = "neorg" },
				{ name = "pypi" },
				{ name = "vim-dadbod-completion" },
				{ name = "env" },
				{ name = "calc" },
				{ name = "codeium" },
				{ name = "git" },
				{ name = "conventionalcommits" },
			},
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			formatting = {
				fields = { "abbr", "kind", "menu" },
				format = function(entry, vim_item)
					vim_item.kind = kind_icons[vim_item.kind]
					vim_item.menu = ({
						git = "[git]",
						conventionalcommits = "[CC]",
						calc = "[calc]",
						nvim_lsp = "[LSP]",
						nvim_lua = "[lua]",
						async_path = "[path]",
						codeium = "[codeium]",
						luasnip = "[snip]",
						neorg = "[neorg]",
						crates = "[crates]",
						pypi = "[pypi]",
						vim_dadbod_completion = "[DB]",
						env = "[env]",
						buffer = "[buf]",
					})[entry.source.name]
					return vim_item
				end,
				expandable_indicator = true,
			},

			experimental = {
				ghost_text = true,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			confirm_opts = {
				behavior = cmp.ConfirmBehavior.Replace,
				select = false,
			},
			filetypes = {
				sorting = {
					priority_weight = 2,
					comparators = {
						-- deprioritize `.box`, `.mut`, etc.
						require("cmp-rust").deprioritize_postfix,
						-- deprioritize `Borrow::borrow` and `BorrowMut::borrow_mut`
						require("cmp-rust").deprioritize_borrow,
						-- deprioritize `Deref::deref` and `DerefMut::deref_mut`
						require("cmp-rust").deprioritize_deref,
						-- deprioritize `Into::into`, `Clone::clone`, etc.
						require("cmp-rust").deprioritize_common_traits,
						compare.offset,
						compare.exact,
						compare.score,
						compare.recently_used,
						compare.locality,
						compare.sort_text,
						compare.length,
						compare.order,
					},
				},
			},
		})

		--[[ cmp.setup.cmdline("/", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		}) ]]
	end,
}
