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
			event = { "BufRead pyproject.toml" },
		},
		"SergioRibera/cmp-dotenv",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-calc",
		"Exafunction/codeium.nvim",
		"petertriho/cmp-git",
		"davidsierradz/cmp-conventionalcommits",
		"zjp-CN/nvim-cmp-lsp-rs",
		{
			"MattiasMTS/cmp-dbee",
			dependencies = {
				{ "kndndrj/nvim-dbee" },
			},
			ft = { "sql", "mysql", "plsql" },
			opts = {},
		},
	},
	opts = function(_, opts)
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local cmp_lsp_rs = require("cmp_lsp_rs")
		local comparators = cmp_lsp_rs.comparators
		local compare = require("cmp").config.compare
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
		opts = {
			mapping = {
				["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
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
				{ name = "cmp-dbee" },
				{ name = "luasnip" },
				{ name = "buffer", keyword_length = 4 },
				{ name = "neorg" },
				{ name = "pypi" },
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
						env = "[env]",
						buffer = "[buf]",
						["cmp-dbee"] = "[DB]",
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
			sorting = {
				comparators = {
					compare.exact,
					compare.score,
					-- comparators.inherent_import_inscope,
					comparators.inscope_inherent_import,
					comparators.sort_by_label_but_underscore_last,
				},
			},
		}
		for _, source in ipairs(opts.sources) do
			cmp_lsp_rs.filter_out.entry_filter(source)
		end
		return opts
	end,
	config = function(_, opts)
		require("cmp").setup(opts)
	end,
}
