local M = {}

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
	return
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.update_capabilities(M.capabilities)

M.setup = function()
	local signs = {

		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		virtual_text = false, -- disable virtual text
		signs = {
			active = signs, -- show signs
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})
end

local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true }
	local keymap = vim.api.nvim_buf_set_keymap
	keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	vim.cmd([[command! Format execute "lua vim.lsp.buf.format()"]])
	keymap(bufnr, "n", "<leader>li", "<cmd>LspInfo<cr>", opts)
	keymap(bufnr, "n", "<leader>lI", "<cmd>LspInstallInfo<cr>", opts)
	keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
	keymap(bufnr, "n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
	keymap(bufnr, "n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
	keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
	keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
end

M.on_attach = function(client, bufnr)
	-- if client.name == "tsserver" then
	-- 	client.resolved_capabilities.document_formatting = false
	-- end
	--
	-- if client.name == "sumneko_lua" then
	-- 	client.resolved_capabilities.document_formatting = false
	-- end

	lsp_keymaps(bufnr)
	local status_ok, illuminate = pcall(require, "illuminate")
	if not status_ok then
		return
	end
	illuminate.configure({
		-- providers: provider used to get references in the buffer, ordered by priority
		providers = {
			"lsp",
			"treesitter",
			"regex",
		},
		-- delay: delay in milliseconds
		delay = 100,
		-- filetype_overrides: filetype specific overrides.
		-- The keys are strings to represent the filetype while the values are tables that
		-- supports the same keys passed to .configure except for filetypes_denylist and filetypes_allowlist
		filetype_overrides = {},
		-- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
		filetypes_denylist = {
			"dirvish",
			"fugitive",
			"alpha",
			"NvimTree",
		},
		-- filetypes_allowlist: filetypes to illuminate, this is overriden by filetypes_denylist
		filetypes_allowlist = {},
		-- modes_denylist: modes to not illuminate, this overrides modes_allowlist
		modes_denylist = {},
		-- modes_allowlist: modes to illuminate, this is overriden by modes_denylist
		modes_allowlist = {},
		-- providers_regex_syntax_denylist: syntax to not illuminate, this overrides providers_regex_syntax_allowlist
		-- Only applies to the 'regex' provider
		-- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
		providers_regex_syntax_denylist = {},
		-- providers_regex_syntax_allowlist: syntax to illuminate, this is overriden by providers_regex_syntax_denylist
		-- Only applies to the 'regex' provider
		-- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
		providers_regex_syntax_allowlist = {},
		-- under_cursor: whether or not to illuminate under the cursor
		under_cursor = true,
		-- max_file_lines: max number of lines in a file to illuminate
		max_file_lines = nil,
	})
	illuminate.on_attach(client)
end

return M
