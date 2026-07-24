vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.wrap = true
vim.opt_local.spell = true
vim.opt_local.spelllang = "lv"
vim.opt_local.textwidth = 80
vim.opt_local.colorcolumn = "80"

local function open_pdf()
	local filepath = vim.api.nvim_buf_get_name(0)
	if filepath:match("%.typ$") then
		local pdf_path = filepath:gsub("%.typ$", ".pdf"):gsub("/([^/]+)%.pdf$", "/target/%1.pdf")
		vim.system({ "xdg-open", pdf_path })
	end
end

vim.api.nvim_create_user_command("OpenPdf", open_pdf, {})
vim.keymap.set("n", "<leader>oo", open_pdf, { desc = "Open compiled pdf file" })
