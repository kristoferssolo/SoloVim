local M = {}

M.setup = function(lsp, capabilities)
	lsp.lua_ls.setup({
		capabilities = capabilities,
		settings = {
			exportPdf = "onSave",
		},
	})
end

return M
