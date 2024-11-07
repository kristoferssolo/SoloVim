-- Use 'q' to quit from common pluginscmd
vim.api.nvim_create_autocmd({ "FileType" }, {
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
		local file_path = vim.fs.normalize(vim.fn.expand("%:p")):lower()
		local exclude_pattern = "dio"

		if not string.match(file_path:lower(), exclude_pattern:lower()) then
			vim.lsp.buf.format()
		end
	end,
})

-- Center on InsertEnter
vim.api.nvim_create_autocmd({ "InsertEnter" }, {
	callback = function()
		vim.cmd("normal! zz")
	end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	pattern = "**/Codnity/**",
	callback = function()
		vim.opt.colorcolumn = "79"
	end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	pattern = "requirements*.txt",
	callback = function()
		vim.cmd("setf requirements")
	end,
})

--[[ vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	pattern = "**/Codnity/**/*.html",
	callback = function()
		vim.cmd("setf htmldjango")
	end,
}) ]]

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
	extension = {
		["http"] = "http",
	},
})

vim.filetype.add({
	pattern = {
		["*.bru"] = "js",
	},
})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
	callback = function()
		if vim.env.TMUX_PLUGIN_MANAGER_PATH then
			vim.loop.spawn(
				vim.env.TMUX_PLUGIN_MANAGER_PATH .. "/tmux-window-name/scripts/rename_session_windows.py",
				{}
			)
		end
	end,
})

--[[ local function setup_soft_wrap()
	vim.opt_local.wrap = true
	vim.opt_local.linebreak = true
	vim.opt_local.columns = 85
	vim.api.nvim_create_autocmd({ "VimResized" }, {
		buffer = 0,
		callback = function()
			if vim.opt.columns:get() > 85 then
				vim.opt.columns = 85
			end
		end,
	})
	vim.opt_local.colorcolumn = "80"
end

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "markdown", "norg", "typst", "tex" },
	callback = setup_soft_wrap,
}) ]]
