local M = {}

local code_namespace = vim.api.nvim_create_namespace("config_code_without_italics")
local overridden = {}
local document_filetypes = {
	asciidoc = true,
	help = true,
	markdown = true,
	norg = true,
	org = true,
	quarto = true,
	rmd = true,
	rst = true,
	vimwiki = true,
}

local function refresh_highlights()
	-- Keep the theme's full styling globally for documents and plugin text.
	for name, highlight in pairs(vim.api.nvim_get_hl(0, {})) do
		if highlight.italic or (highlight.cterm and highlight.cterm.italic) or overridden[name] then
			highlight.italic = false
			if highlight.cterm then
				highlight.cterm.italic = false
			end
			vim.api.nvim_set_hl(code_namespace, name, highlight)
			overridden[name] = true
		end
	end
end

local function update_windows()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		local filetype = vim.bo[buf].filetype
		local upright = filetype == "oil"
			or vim.startswith(filetype, "Neogit")
			or (vim.bo[buf].buftype == "" and not document_filetypes[filetype])
		if upright then
			vim.api.nvim_win_set_hl_ns(win, code_namespace)
		elseif vim.api.nvim_get_hl_ns({ winid = win }) == code_namespace then
			vim.api.nvim_win_set_hl_ns(win, 0)
		end
	end
end

function M.setup()
	local group = vim.api.nvim_create_augroup("config_document_italics", { clear = true })
	vim.api.nvim_create_autocmd({ "ColorScheme", "FileType", "VimEnter" }, {
		group = group,
		callback = function()
			refresh_highlights()
			update_windows()
		end,
	})
	vim.api.nvim_create_autocmd({ "BufWinEnter", "WinEnter" }, {
		group = group,
		callback = update_windows,
	})
	refresh_highlights()
	update_windows()
end

return M
