local M = {}

M.setup = function(lsp, capabilities)
	lsp.typst_lsp.setup({
		capabilities = capabilities,
		settings = {
			exportPdf = "onType", -- Choose onType, onSave or never.
		},
	})
end

return M
