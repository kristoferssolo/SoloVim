local M = {}

M.setup = function(lsp, capabilities)
	lsp.pylyzer.setup({
		capabilities = capabilities,
		settings = {
			python = {
				diagnostics = true,
				inlayHints = true,
				smartCompletion = true,
				checkOnType = true,
			},
		},
	})
end

return M
