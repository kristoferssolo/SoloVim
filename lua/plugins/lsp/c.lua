local M = {}

M.setup = function(lsp, capabilities)
	lsp.clangd.setup({
		capabilities = capabilities,
	})
end

return M
