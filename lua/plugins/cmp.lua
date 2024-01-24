return {
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	lazy = false,
	dependencies = {
		"hrsh7th/cmp-buffer", -- buffer completions
		"FelipeLema/cmp-async-path", -- path completionsplu
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
		"hrsh7th/cmp-emoji",
		"hrsh7th/cmp-calc",
		{ "zbirenbaum/copilot-cmp", opts = {}, dependencies = { "zbirenbaum/copilot.lua" } },
		"Exafunction/codeium.nvim",
		"chrisgrieser/cmp-nerdfont",
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
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
				["<C-k>"] = cmp.mapping.select_prev_item(),
				["<C-j>"] = cmp.mapping.select_next_item(),
				["<C-d>"] = cmp.mapping.scroll_docs(-4),
				["<C-u>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping({
					i = cmp.mapping.abort(),
					c = cmp.mapping.close(),
				}),
				-- Accept currently selected item. If none selected, `select` first item.
				-- Set `select` to `false` to only confirm explicitly selected items.
				["<cr>"] = cmp.mapping.confirm({ select = true }),
			},
			sources = {
				{ name = "nvim_lua" },
				{ name = "nvim_lsp" },
				{ name = "crates" },
				{ name = "async_path" },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "neorg" },
				{ name = "pypi" },
				{ name = "dadbod" },
				{ name = "env" },
				{ name = "calc" },
				{ name = "emoji" },
				{ name = "copilot" },
				{ name = "codeium" },
				{ name = "nerdfont" },
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
						calc = "[calc]",
						emoji = "[emoji]",
						nerdfont = "[nerdfont]",
						nvim_lsp = "[LSP]",
						nvim_lua = "[lua]",
						copilot = "[copilot]",
						codeium = "[codeium]",
						luasnip = "[snip]",
						async_path = "[path]",
						neorg = "[neorg]",
						crates = "[crates]",
						pypi = "[pypi]",
						dadbod = "[dadbod]",
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
		})
	end,
}