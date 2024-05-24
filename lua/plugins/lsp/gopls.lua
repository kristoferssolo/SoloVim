local M = {}

M.setup = function(lsp, capabilities)
	lsp.gopls.setup({
		capabilities = capabilities,
		settings = {
			hints = {
				rangeVariableTypes = true,
				parameterNames = true,
				constantValues = true,
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				functionTypeParameters = true,
			},
		},
	})
end

return M
