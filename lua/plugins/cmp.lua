return {
	{
		"hrsh7th/nvim-cmp",
		-- event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-buffer", -- buffer completions
			"hrsh7th/cmp-path", -- path completionsplu
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp",
		},
	}, -- The completion pluginpluguse "nvim-lua/plenary.nvim"
	"saadparwaiz1/cmp_luasnip", -- snippet completions
}
