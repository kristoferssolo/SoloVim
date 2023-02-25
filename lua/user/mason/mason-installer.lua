local status_ok, mason = pcall(require, "mason")
if not status_ok then
	return
end

local status_mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_mason_lspconfig_ok then
	return
end

local status_lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not status_lspconfig_ok then
	return
end

local status_update_all_ok, mason_update_all = pcall(require, "mason-update-all")
if not status_update_all_ok then
	return
end

local status_tool_ok, mason_tool = pcall(require, "mason-tool-installer")
if not status_tool_ok then
	return
end

mason.setup()
mason_lspconfig.setup()
mason_update_all.setup()

local servers = {
	"bashls",
	"cssls",
	"clangd",
	"emmet_ls",
	"html",
	"jsonls",
	-- "pyright",
	"jedi_language_server",
	"rust_analyzer",
	"lua_ls",
	"taplo",
	"texlab",
	"tsserver",
	"vimls",
	"yamlls",
}

mason_tool.setup({
	ensure_installed = {
		"bash-language-server",
		"clangd",
		"css-lsp",
		"diagnostic-languageserver",
		"emmet-ls",
		"html-lsp",
		"json-lsp",
		"lua-language-server",
		"marksman",
		-- "pyright",
		"jedi-language-server",
		"rust-analyzer",
		"taplo",
		"texlab",
		"typescript-language-server",
		"vim-language-server",
		"yaml-language-server",
	},
	auto_update = true,
	run_on_start = true,
	start_delay = 0,
})

local opts = {}

for _, server in pairs(servers) do
	opts = {
		on_attach = require("user.mason.handlers").on_attach,
		capabilities = require("user.mason.handlers").capabilities,
	}

	-- if server == "jedi_language_server" then
	-- 	local pyright_opts = require("user.mason.settings.jedi")
	-- 	opts = vim.tbl_deep_extend("force", pyright_opts, opts)
	-- end

	-- if server == "clangd" then
	-- 	local clangd_opts = require("user.mason.settings.clangd")
	-- 	opts = vim.tbl_deep_extend("force", clangd_opts)
	-- end
	--
	-- if server == "html" then
	-- 	local html_opts = require("user.mason.settings.html")
	-- 	opts = vim.tbl_deep_extend("force", html_opts)
	-- if server == "lua_ls" then
	-- 	local lua_ls_opts = require("user.mason.settings.lua_ls")
	-- 	opts = vim.tbl_deep_extend("force", lua_ls_opts, opts)
	-- end

	if server == "rust_analyzer" then
		local keymap = vim.keymap.set
		local key_opts = { silent = true }

		keymap("n", "<leader>rh", "<cmd>RustSetInlayHints<Cr>", key_opts)
		keymap("n", "<leader>rhd", "<cmd>RustDisableInlayHints<Cr>", key_opts)
		keymap("n", "<leader>th", "<cmd>RustToggleInlayHints<Cr>", key_opts)
		keymap("n", "<leader>rr", "<cmd>RustRunnables<Cr>", key_opts)
		keymap("n", "<leader>rem", "<cmd>RustExpandMacro<Cr>", key_opts)
		keymap("n", "<leader>roc", "<cmd>RustOpenCargo<Cr>", key_opts)
		keymap("n", "<leader>rpm", "<cmd>RustParentModule<Cr>", key_opts)
		keymap("n", "<leader>rjl", "<cmd>RustJoinLines<Cr>", key_opts)
		keymap("n", "<leader>rha", "<cmd>RustHoverActions<Cr>", key_opts)
		keymap("n", "<leader>rhr", "<cmd>RustHoverRange<Cr>", key_opts)
		keymap("n", "<leader>rmd", "<cmd>RustMoveItemDown<Cr>", key_opts)
		keymap("n", "<leader>rmu", "<cmd>RustMoveItemUp<Cr>", key_opts)
		keymap("n", "<leader>rsb", "<cmd>RustStartStandaloneServerForBuffer<Cr>", key_opts)
		keymap("n", "<leader>rd", "<cmd>RustDebuggables<Cr>", key_opts)
		keymap("n", "<leader>rv", "<cmd>RustViewCrateGraph<Cr>", key_opts)
		keymap("n", "<leader>rw", "<cmd>RustReloadWorkspace<Cr>", key_opts)
		keymap("n", "<leader>rss", "<cmd>RustSSR<Cr>", key_opts)
		keymap("n", "<leader>rxd", "<cmd>RustOpenExternalDocs<Cr>", key_opts)

		require("rust-tools").setup({
			tools = {
				on_initialized = function()
					vim.cmd([[
                        autocmd BufEnter,CursorHold,InsertLeave,BufWritePost *.rs silent! lua vim.lsp.codelens.refresh()
                    ]])
				end,
			},
			server = {
				on_attach = require("user.mason.handlers").on_attach,
				capabilities = require("user.mason.handlers").capabilities,
				settings = {
					["rust-analyzer"] = {
						lens = {
							enable = true,
						},
						checkOnSave = {
							command = "clippy",
						},
					},
				},
			},
		})

		goto continue
	end

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.offsetEncoding = { "utf-16" }

	if server == "clangd" then
		require("clangd_extensions").setup({
			server = {
				capabilities = capabilities,
				-- options to pass to nvim-lspconfig
				-- i.e. the arguments to require("lspconfig").clangd.setup({})
			},
			extensions = {
				-- defaults:
				-- Automatically set inlay hints (type hints)
				autoSetHints = true,
				-- These apply to the default ClangdSetInlayHints command
				inlay_hints = {
					-- Only show inlay hints for the current line
					only_current_line = false,
					-- Event which triggers a refersh of the inlay hints.
					-- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
					-- not that this may cause  higher CPU usage.
					-- This option is only respected when only_current_line and
					-- autoSetHints both are true.
					only_current_line_autocmd = "CursorHold",
					-- whether to show parameter hints with the inlay hints or not
					show_parameter_hints = true,
					-- prefix for parameter hints
					parameter_hints_prefix = "<- ",
					-- prefix for all the other hints (type, chaining)
					other_hints_prefix = "=> ",
					-- whether to align to the length of the longest line in the file
					max_len_align = false,
					-- padding from the left if max_len_align is true
					max_len_align_padding = 1,
					-- whether to align to the extreme right or not
					right_align = false,
					-- padding from the right if right_align is true
					right_align_padding = 7,
					-- The color of the hints
					highlight = "Comment",
					-- The highlight group priority for extmark
					priority = 100,
				},
				ast = {
					-- -- These are unicode, should be available in any font
					-- role_icons = {
					-- 	type = "🄣",
					-- 	declaration = "🄓",
					-- 	expression = "🄔",
					-- 	statement = ";",
					-- 	specifier = "🄢",
					-- 	["template argument"] = "🆃",
					-- },
					-- kind_icons = {
					-- 	Compound = "🄲",
					-- 	Recovery = "🅁",
					-- 	TranslationUnit = "🅄",
					-- 	PackExpansion = "🄿",
					-- 	TemplateTypeParm = "🅃",
					-- 	TemplateTemplateParm = "🅃",
					-- 	TemplateParamObject = "🅃",
					-- },
					-- These require codicons (https://github.com/microsoft/vscode-codicons)
					role_icons = {
						type = "",
						declaration = "",
						expression = "",
						specifier = "",
						statement = "",
						["template argument"] = "",
					},

					kind_icons = {
						Compound = "",
						Recovery = "",
						TranslationUnit = "",
						PackExpansion = "",
						TemplateTypeParm = "",
						TemplateTemplateParm = "",
						TemplateParamObject = "",
					},

					highlights = {
						detail = "Comment",
					},
				},
				memory_usage = {
					border = "none",
				},
				symbol_info = {
					border = "none",
				},
			},
		})
		goto continue
	end

	lspconfig[server].setup(opts)
	::continue::
end
