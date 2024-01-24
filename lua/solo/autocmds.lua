-- Use 'q' to quit from common pluginscmd
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "qf", "help", "man", "lspinfo", "spectre_panel", "lir", "git", "dap-float" },
	callback = function()
		vim.cmd([[ nnoremap <silent> <buffer> q :close<cr>
            set nobuflisted
        ]])
	end,
})

-- Fixes Autocomment
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	callback = function()
		vim.cmd("set formatoptions-=cro")
	end,
})

-- Highlight Yanked Text
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
	end,
})

-- Format File on Save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	callback = function()
		vim.lsp.buf.format()
	end,
})

-- Center on InsertEnter
vim.api.nvim_create_autocmd({ "InsertEnter" }, {
	callback = function()
		vim.cmd("norm zz")
	end,
})

-- Autocommand that reloads waybar whenever you save the ~/.config/waybar/config file
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	group = vim.api.nvim_create_augroup("AutoReloadWaybar", { clear = true }),
	pattern = { "**/waybar/config", "**/waybar/style.css" },
	callback = function()
		vim.cmd("!pkill waybar && waybar & disown")
	end,
})

-- Autocommand that sources neovim files on save
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	group = vim.api.nvim_create_augroup("AutoReloadConfig", { clear = true }),
	pattern = { "**/nvim/**/*.lua", "**/SoloVim/**/*.lua" },
	callback = function()
		local file_path = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
		vim.cmd.source(file_path)
	end,
})

-- Remove trailing whitespaces on save
-- vim.api.nvim_create_autocmd({ "BufWritePre" }, {
-- 	group = vim.api.nvim_create_augroup("RemoveTrailingWhitespaces", { clear = true }),
-- 	pattern = "*",
-- 	callback = function()
-- 		vim.cmd([[%s/\s\+$//e]])
-- 	end,
-- })

-- Run `Lazy` on file save
-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
-- 	group = vim.api.nvim_create_augroup("AutoPackerSync", { clear = true }),
-- 	pattern = { "**/lua/plugins/*" },
-- 	callback = function()
-- 		require("lazy").sync()
-- 	end,
-- })

-- Set vertical column for specific files
-- vim.api.nvim_create_autocmd({ "FileType" }, {
-- 	group = vim.api.nvim_create_augroup("SetColorColumn", { clear = true }),
-- 	pattern = { "lua" },
-- 	callback = function()
-- 		vim.cmd.setlocal("colorcolumn=120")
-- 	end,
-- })
