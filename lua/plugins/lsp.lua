return {
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" }, -- Required
			{ "williamboman/mason.nvim" }, -- Optional
			{ "williamboman/mason-lspconfig.nvim" }, -- Optional

			-- Autocompletion
			{
				"hrsh7th/nvim-cmp",
				event = "InsertEnter",
				dependencies = {
					"hrsh7th/cmp-buffer", -- buffer completions
					"hrsh7th/cmp-path", -- path completionsplu
					"hrsh7th/cmp-nvim-lua",
					"hrsh7th/cmp-nvim-lsp",
				},
			}, -- Required
			{ "hrsh7th/cmp-nvim-lsp" }, -- Required
			{
				"L3MON4D3/LuaSnip",
				build = "make install_jsregexp",
				dependencies = {
					"rafamadriz/friendly-snippets", -- a bunch of snippets to use
				},
			}, -- Required
			{ "saadparwaiz1/cmp_luasnip" },
		},
	},

	{
		"windwp/nvim-autopairs", -- Autopairs, integrates with both cmp and treesitter
		event = "InsertEnter",
		opts = {
			check_ts = true, -- treesitter integration
			disable_filetype = {
				"NvimTree",
				"TelescopePrompt",
				"alpha",
				"lazy",
			},
		},
	},

	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"jose-elias-alvarez/null-ls.nvim",
		},
	},

	-- for formatters and linters
	{ "nanotee/sqls.nvim", lazy = true },
}
