vim.cmd([[
	aunmenu PopUp
	anoremenu PopUp.Inspect       <cmd>Inspect<cr>
	amenu PopUp.-1-               <cmd>Inspect<cr>
	anoremenu PopUp.Definition    <cmd>lua vim.lsp.buf.definition()<cr>
	anoremenu PopUp.References    <cmd>Telescope lsp_references<cr>
	nnoremenu PopUp.Back          <C-t>
	amenu PopUp.-2-               <cmd>Inspect<cr>
	amenu PopUp.URL               gx
]])

local group = vim.api.nvim_create_augroup("nvim_popupmenu", { clear = true })
vim.api.nvim_create_autocmd("MenuPopup", {
	pattern = "*",
	group = group,
	desc = "Custom PopUp Setup",
	callback = function()
		vim.cmd([[
				amenu disable PopUp.-1-
				amenu disable PopUp.Definition
				amenu disable PopUp.References
				amenu disable PopUp.URL
			]])
		if vim.lsp.get_clients({ bufnr = 0 })[1] then
			vim.cmd([[
				amenu enable PopUp.Definition
				amenu enable PopUp.References
			]])
		end
		local urls = require("vim.ui")._get_urls()
		if vim.startswith(urls[1], "http") then
			vim.cmd([[
				amenu disable Popup.-2-
				amentu enable PopUp.URL
			]])
		end
	end,
})
