local M = {}

M.setup = function(lsp, capabilities)
	lsp.emmet_ls.setup({
		capabilities = capabilities,
		filetypes = {
			"html",
			"htmldjango",
			-- "typescriptreact",
			-- "javascriptreact",
			"css",
			"sass",
			"scss",
			"less",
			"eruby",
		},
	})
end

return M
