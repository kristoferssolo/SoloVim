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

vim.api.nvim_create_user_command("W", function(opts)
	local skip = vim.g.skip_format_on_save
	vim.g.skip_format_on_save = true
	if opts.bang then
		vim.cmd("write!")
	else
		vim.cmd("write")
	end
	vim.g.skip_format_on_save = skip
end, { bang = true, nargs = "?" })
