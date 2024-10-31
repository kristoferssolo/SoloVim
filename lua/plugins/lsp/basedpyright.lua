local M = {}

M.setup = function(lsp, capabilities)
	lsp.basedpyright.setup({
		capabilities = capabilities,
		basedpyright = {
			analysis = {
				autoSearchPaths = true,
				diagnosticMode = "openFilesOnly",
				useLibraryCodeForTypes = true,
			},
		},
	})
end

return M
