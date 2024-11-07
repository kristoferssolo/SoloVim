local M = {}

M.setup = function(lsp, capabilities)
	lsp.tinymist.setup({
		capabilities = capabilities,
		offset_encoding = "utf-8",
		settings = {
			exportPdf = "onType",
			outputPath = "$root/target/$dir/$name",
		},
	})
end

return M
