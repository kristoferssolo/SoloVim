local M = {}

M.setup = function(lsp, capabilities)
	lsp.rust.setup({
		capabilities = capabilities,
		hint = {
			enable = true,
		},
	})
end

return M
