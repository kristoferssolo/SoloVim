local M = {}

M.setup = function(lsp, capabilities)
	lsp.tinymist.setup({
		capabilities = capabilities,
		settings = {
			exportPdf = "onType",
			outputPath = "$root/target/$dir/$name",
		},
	})
end

return M
