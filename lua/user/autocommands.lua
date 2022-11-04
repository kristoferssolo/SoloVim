-- Use 'q' to quit from common plugins

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "qf", "help", "man", "lspinfo", "spectre_panel", "lir" },
	callback = function()
		vim.cmd([[
            nnoremap <silent> <buffer> q :close<CR> 
            set nobuflisted 
        ]])
	end,
})

-- Remove statusline and tabline when in Alpha
vim.api.nvim_create_autocmd({ "User" }, {
	pattern = { "AlphaReady" },
	callback = function()
		vim.cmd([[
            set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
            set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3
        ]])
	end,
})

-- Set wrap and spell in markdown and gitcommit
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "gitcommit", "markdown", "vimwiki" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
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
		-- vim.lsp.buf.format({ async = true })
	end,
})

-- Center on InsertEnter
vim.api.nvim_create_autocmd({ "InsertEnter" }, {
	callback = function()
		vim.cmd("norm zz")
	end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "c", "cpp", "yaml", "vimwiki", "markdown", "html", "css", "json" },
	callback = function()
		vim.opt_local.ts = 2
		vim.opt_local.sw = 2
		vim.opt_local.sts = 2
	end,
})

-- Change Cursorline/Columnt color
vim.cmd([[
    highlight CursorLine ctermbg=White cterm=bold guibg=#222222
    highlight CursorColumn ctermbg=White cterm=bold guibg=#222222
    autocmd FileType python imap <buffer> <C-b> <esc><cmd>w<CR><cmd>exec "!python3" shellescape(@%, 1)<CR>
    autocmd FileType python map <buffer> <C-b> <cmd>w<CR><cmd>exec "!python3" shellescape(@%, 1)<CR>
    autocmd FileType rust imap <buffer> <C-b> <esc><cmd>w<CR><cmd>exec "!cargo run"<CR>
    autocmd FileType rust map <buffer> <C-b> <cmd>w<CR><cmd>exec "!cargo run"<CR>
    autocmd FileType tex imap <buffer> <C-b> <esc><cmd>w<CR><cmd>exec "silent !lualatex %"<CR>
    autocmd FileType tex map <buffer> <C-b> <esc><cmd>w<CR><cmd>exec "silent !lualatex %"<CR>
]])
