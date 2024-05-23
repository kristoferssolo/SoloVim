local M = {}

M.setup = function(lsp, capabilities)
	capabilities = capabilities
	lsp.ruff_lsp.setup({
		init_options = {
			settings = {
				args = {},
			},
		},
	})
end

return M
