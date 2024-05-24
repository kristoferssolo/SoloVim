local M = {}

M.setup = function(lsp, capabilities)
	lsp.html.setup({
		capabilities = capabilities,
		filetypes = {
			"html",
			"htmldjango",
			"templ",
		},
		init_options = {
			provideFormatter = false,
		},
	})
end

return M
