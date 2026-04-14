return {
	"mason-org/mason-lspconfig.nvim",
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"neovim/nvim-lspconfig",
	},
	opts = {
		ensure_installed = {
			-- "basedpyright",
			"bashls",
			"css_variables",
			"cssls",
			"html",
			"hyprls",
			"jsonls",
			"lua_ls",
			"markdown_oxide",
			"ruff",
			"tinymist",
			-- "ty",
			"zuban",
		},
	},
}
