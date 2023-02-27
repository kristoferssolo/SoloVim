return {
	tools = {
		on_initialized = function()
			vim.cmd([[
                        autocmd BufEnter,CursorHold,InsertLeave,BufWritePost *.rs silent! lua vim.lsp.codelens.refresh()
                    ]])
		end,
	},
	settings = {
		["rust-analyzer"] = {
			lens = {
				enable = true,
			},
			checkOnSave = {
				command = "clippy",
			},
		},
	},
}
