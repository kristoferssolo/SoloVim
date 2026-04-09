-- Use 'q' to quit from common pluginscmd
vim.api.nvim_create_autocmd({ "FileType" }, {
	group = vim.api.nvim_create_augroup("config_close_with_q", { clear = true }),
	pattern = {
		"qf",
		"help",
		"man",
		"lspinfo",
		"spectre_panel",
		"lir",
		"git",
		"dap-float",
		"fugitive",
		"gitcommit",
		"startuptime",
	},
	callback = function()
		vim.cmd([[ nnoremap <silent> <buffer> q :close<cr>
            set nobuflisted
        ]])
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("config_cursorcolumn_filetypes", { clear = true }),
	pattern = { "csv", "tsv" },
	callback = function()
		vim.opt_local.cursorcolumn = true
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("config_formatoptions", { clear = true }),
	callback = function()
		vim.cmd("set formatoptions-=cro")
	end,
})

-- Highlight Yanked Text
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	group = vim.api.nvim_create_augroup("config_highlight_yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 100 })
	end,
})

-- Center (zz) on InsertEnter
vim.api.nvim_create_autocmd({ "InsertEnter" }, {
	group = vim.api.nvim_create_augroup("config_center_on_insert", { clear = true }),
	callback = function()
		vim.cmd("normal! zz")
	end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	group = vim.api.nvim_create_augroup("config_requirements_filetype", { clear = true }),
	pattern = "requirements*.txt",
	callback = function()
		vim.cmd("setf requirements")
	end,
})

-- Autocommand that sources neovim files on save
--[[ vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	group = vim.api.nvim_create_augroup("config_reload_neovim", { clear = true }),
	pattern = { "**/nvim/**/*.lua", "**/SoloVim/**/*.lua" },
	callback = function()
		local file_path = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
		vim.cmd.source(file_path)
	end,
}) ]]

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	group = vim.api.nvim_create_augroup("config_reload_eww", { clear = true }),
	pattern = { "**/eww.yuck", "**/eww.scss" },
	callback = function()
		vim.fn.system("eww reload")
	end,
})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
	group = vim.api.nvim_create_augroup("config_rename_tmux_windows", { clear = true }),
	callback = function()
		if vim.env.TMUX_PLUGIN_MANAGER_PATH then
			vim.loop.spawn(
				vim.env.TMUX_PLUGIN_MANAGER_PATH .. "/tmux-window-name/scripts/rename_session_windows.py",
				{}
			)
		end
	end,
})
