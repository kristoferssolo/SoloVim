-- Use 'q' to quit from common plugins
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "qf", "help", "man", "lspinfo", "spectre_panel", "lir" },
	callback = function()
		vim.cmd([[ nnoremap <silent> <buffer> q :close<cr>
            set nobuflisted
        ]])
	end,
})

-- Remove statusline and tabline when in Alpha
-- vim.api.nvim_create_autocmd({ "User" }, {
-- 	pattern = { "AlphaReady" },
-- 	callback = function()
-- 		vim.cmd([[
--             set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
--             set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3
--         ]])
-- 	end,
-- })

-- Set wrap and spell in markdown and gitcommit
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "gitcommit", "markdown", "vimwiki" },
	callback = function()
		vim.opt_local.wrap = true
		-- vim.opt_local.spell = true
	end,
})

vim.cmd("autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif")

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

-- Disable `expandtab` (don't replace tab with spaces) for lua files
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "lua" },
	callback = function()
		vim.opt_local.expandtab = false
	end,
})

-- Set tab size for the following file types to 2
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "vimwiki", "sql" },
	callback = function()
		vim.opt_local.ts = 2
		vim.opt_local.sw = 2
		vim.opt_local.sts = 2
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

-- Run lazy on file save
-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
-- 	group = vim.api.nvim_create_augroup("AutoPackerSync", { clear = true }),
-- 	pattern = { "**/lua/plugins/*" },
-- 	callback = function()
-- 		require("lazy").sync()
-- 	end,
-- })
