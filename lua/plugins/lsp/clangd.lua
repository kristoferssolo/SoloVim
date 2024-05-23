local M = {}

M.setup = function(lsp, capabilities)
	capabilities = capabilities
	lsp.clangd.setup({
		capabilities = capabilities,
		--[[ settings = {
			clangd = {
				InlayHints = {
					Designators = true,
					Enabled = true,
					ParameterNames = true,
					DeducedTypes = true,
				},
				fallbackFlags = { "-std=c++20" },
			},
		}, ]]
	})
end

return M
