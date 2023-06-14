local status_ok, mason = pcall(require, "mason")
if not status_ok then
	return
end
local status_lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not status_lspconfig_ok then
	return
end

local status_mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_mason_lspconfig_ok then
	return
end

local servers = {
	"bashls",
	"clangd",
	"cmake",
	"cssls",
	"emmet_ls",
	"html",
	"jedi_language_server",
	"jsonls",
	"lua_ls",
	"phpactor",
	"ruff_lsp",
	"rust_analyzer",
	"sqlls",
	"taplo",
	"texlab",
	"tsserver",
}

mason.setup()

mason_lspconfig.setup({
	ensure_installed = servers,
})

local on_attach = require("solo.mason.handlers").on_attach
local capabilities = require("solo.mason.handlers").capabilities
for _, server in pairs(servers) do
	local opts = {
		capabilities = capabilities,
		on_attach = on_attach,
	}

	if server == "bashls" then
		local bashls_opts = require("solo.mason.settings.bashls")
		opts = vim.tbl_deep_extend("force", bashls_opts, opts)
	end

	if server == "lua_ls" then
		local lua_ls_opts = require("solo.mason.settings.lua_ls")
		opts = vim.tbl_deep_extend("force", lua_ls_opts, opts)
	end

	if server == "emmet_ls" then
		local emmet_ls_opts = require("solo.mason.settings.emmet_ls")
		opts = vim.tbl_deep_extend("force", emmet_ls_opts, opts)
	end

	if server == "rust_analyzer" then
		local rust_analyzer_opts = require("solo.mason.settings.rust_analyzer")
		opts = vim.tbl_deep_extend("force", rust_analyzer_opts, opts)
		require("rust-tools").setup(opts)
		goto continue
	end

	if server == "clangd" then
		local clangd_opts = require("solo.mason.settings.clangd")
		opts = vim.tbl_deep_extend("force", clangd_opts, opts)
		require("clangd_extensions").setup(opts)
		goto continue
	end

	if server == "texlab" then
		local texlab_opts = require("solo.mason.settings.texlab")
		opts = vim.tbl_deep_extend("force", texlab_opts, opts)
	end

	lspconfig[server].setup(opts)
	::continue::
end
