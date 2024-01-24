local M = {}

M.setup = function(lsp, capabilities)
	lsp.bashls.setup({
		capabilities = capabilities,
		filetypes = {
			"sh",
			"bash",
			"zsh",
		},
	})
end

return M
