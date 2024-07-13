local M = {}

M.setup = function(lsp, capabilities)
	lsp.pylsp.setup({
		capabilities = capabilities,
		settings = {
			pylsp = {
				plugins = {
					autopep8 = { enabled = false },
					flake8 = { enabled = false },
					pylint = { enabled = false },
					yapf = { enabled = false },
					pydocstyle = { enabled = false },
					mccabe = { enabled = false },
					rope_autoimport = { enabled = true },
					rope_completion = {
						enabled = true,
						eager = true,
					},
					pycodestyle = {
						maxLineLength = nil,
					},
				},
			},
		},
	})
end

return M
