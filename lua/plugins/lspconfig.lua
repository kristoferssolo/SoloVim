return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"saghen/blink.cmp",
		"nvim-telescope/telescope.nvim",
		"folke/trouble.nvim",
		"folke/neoconf.nvim",
		"piersolenski/telescope-import.nvim",
		"mrcjkb/rustaceanvim",
	},
	opts = function()
		return require("solo.lspconfig-opts")
	end,
	config = function(_, opts)
		require("mason").setup()
		local lspconfig = require("lspconfig")

		local function extend_capabilities(capabilities)
			return vim.tbl_deep_extend("keep", capabilities, {
				textDocument = {
					foldingRange = {
						dynamicRegistration = false,
						lineFoldingOnly = true,
					},
				},
			})
		end

		for server, config in pairs(opts.servers) do
			local capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
			config.capabilities = extend_capabilities(capabilities)
			lspconfig[server].setup(config)
		end

		local default_setup = function(server)
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			lspconfig[server].setup({
				capabilities = extend_capabilities(capabilities),
			})
		end
		vim.api.nvim_create_autocmd("LspAttach", {
			desc = "LSP actions",
			callback = function(event)
				-- these will be buffer-local keybindings
				-- because they only work if language server is active

				local nmap = function(keys, func, desc)
					if desc then
						desc = "LSP: " .. desc
					end
					vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
				end
				local trouble = require("trouble")

				nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
				nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
				nmap("K", vim.lsp.buf.hover, "Hover Documentation")
				nmap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
				vim.keymap.set(
					"i",
					"<C-h>",
					vim.lsp.buf.signature_help,
					{ buffer = event.buf, desc = "LSP: Signature Documentation" }
				)
				nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
				nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
				nmap("<leader>ws", vim.lsp.buf.workspace_symbol, "[W]orkspace [S]ymbol")
				nmap("<leader>wd", vim.diagnostic.open_float, "[W]orkspace [D]iagnostic")
				nmap("<leader>wl", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, "[W]orkspace [L]ist Folders")
				nmap("<leader>lD", vim.lsp.buf.type_definition, "Type [D]efinition")
				nmap("<leader>lr", vim.lsp.buf.rename, "[R]ename")
				nmap("<leader>lj", vim.diagnostic.goto_next, "Diagnostic Next")
				nmap("<leader>lk", vim.diagnostic.goto_prev, "Diagnostic Prev")
				nmap("]d", function()
					trouble.next({ mode = "diagnostics", skip_groups = true, jump = true })
				end, "LSP: Trouble Next")
				nmap("[d", function()
					trouble.prev({ mode = "diagnostics", skip_groups = true, jump = true })
				end, "Trouble Prev")
				vim.keymap.set(
					{ "n", "v" },
					"<leader>la",
					vim.lsp.buf.code_action,
					{ buffer = event.buf, desc = "LSP: Code [A]ction" }
				)
				nmap("gr", function()
					require("trouble").toggle("lsp_references")
				end, "[G]oto [R]eferences")
				nmap("gR", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
			end,
		})

		local signs = {
			{ name = "DiagnosticSignError", text = "" },
			{ name = "DiagnosticSignWarn", text = "" },
			{ name = "DiagnosticSignHint", text = "" },
			{ name = "DiagnosticSignInfo", text = "" },
		}

		for _, sign in ipairs(signs) do
			vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
		end

		vim.diagnostic.config({
			virtual_text = true, -- virtual text
			signs = { active = signs }, -- show signs
			update_in_insert = true,
			underline = true,
			severity_sort = true,
			float = {
				focusable = true,
				style = "minimal",
				border = "rounded",
				source = true,
				header = "",
				prefix = "",
			},
		})

		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
			border = "rounded",
		})

		vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
			border = "rounded",
		})

		require("mason-lspconfig").setup({
			automatic_installation = true,
			automatic_setup = true,
			ensure_installed = {
				-- "basedpyright",
				"bashls",
				"clangd",
				"cmake",
				"cssls",
				"emmet_ls",
				"html",
				"jedi_language_server",
				"lua_ls",
				"tailwindcss",
				"texlab",
				"tinymist",
				"ts_ls",
			},
			handlers = {
				default_setup,
			},
		})
	end,
}
