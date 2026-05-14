vim.api.nvim_create_user_command("OpenPdf", function()
	local filepath = vim.api.nvim_buf_get_name(0)
	if filepath:match("%.typ$") then
		os.execute(
			"sioyek --new-instance"
				.. vim.fn.shellescape(filepath:gsub("%.typ$", ".pdf"):gsub("/([^/]+)%.pdf$", "/target/%1.pdf"))
				.. " 2>/dev/null &"
		)
	end
end, {})

vim.api.nvim_create_user_command("LspInfo", function()
	vim.cmd.checkhealth("vim.lsp")
end, {})
vim.api.nvim_create_user_command("LspStart", function(lopts)
	vim.cmd("lsp enable " .. lopts.args)
end, { nargs = "?" })
vim.api.nvim_create_user_command("LspStop", function(lopts)
	vim.cmd("lsp disable " .. lopts.args)
end, { nargs = "?" })
vim.api.nvim_create_user_command("LspRestart", function(lopts)
	vim.cmd("lsp restart " .. lopts.args)
end, { nargs = "?" })
