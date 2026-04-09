return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"saghen/blink.cmp",
		"folke/snacks.nvim",
		"folke/trouble.nvim",
		"folke/neoconf.nvim",
		"mrcjkb/rustaceanvim",
		"pmizio/typescript-tools.nvim",
	},
	opts = {
		servers = require("config.lsp.servers"),
	},
	config = function(_, opts)
		local lsp = require("config.lsp")

		lsp.setup_attach()
		lsp.setup_diagnostics()

		for server, server_config in pairs(opts.servers) do
			vim.lsp.config(server, lsp.defaults(server_config))
			vim.lsp.enable(server)
		end
	end,
}
