-- Use 'q' to quit from common pluginscmd
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "qf", "help", "man", "lspinfo", "spectre_panel", "lir", "git", "dap-float", "fugitive", "gitcommit" },
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

--[[ vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*.py" },
	callback = function()
		vim.lsp.buf.code_action({
			context = {
				only = { "source.fixAll.ruff" },
			},
			apply = true,
		})
	end,
}) ]]

-- Center on InsertEnter
vim.api.nvim_create_autocmd({ "InsertEnter" }, {
	callback = function()
		vim.cmd("norm zz")
	end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	pattern = "**/Codnity/**",
	callback = function()
		vim.opt.colorcolumn = "92"
	end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	pattern = "requirements*.txt",
	callback = function()
		vim.cmd("setf requirements")
	end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	pattern = "**/Codnity/**/*.html",
	callback = function()
		vim.cmd("setf htmldjango")
	end,
})

-- Autocommand that sources neovim files on save
--[[ vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	group = vim.api.nvim_create_augroup("AutoReloadConfig", { clear = true }),
	pattern = { "**/nvim/**/*.lua", "**/SoloVim/**/*.lua" },
	callback = function()
		local file_path = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
		vim.cmd.source(file_path)
	end,
}) ]]

vim.filetype.add({
	pattern = {
		[".*/hypr/.*%.conf"] = "hyprlang",
	},
})
