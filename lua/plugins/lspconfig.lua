return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"folke/neodev.nvim",
		"nvim-telescope/telescope.nvim",
		"folke/trouble.nvim",
	},

	config = function()
		require("mason").setup()
		local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
		local lsp = require("lspconfig")

		local default_setup = function(server)
			lsp[server].setup({
				capabilities = lsp_capabilities,
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

				nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
				nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
				nmap("K", vim.lsp.buf.hover, "Hover Documentation")
				nmap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
				vim.keymap.set(
					"i",
					"<C-k>",
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
					local trouble = require("trouble")
					trouble.open("workspace_diagnostics")
					trouble.next({ skip_groups = true, jump = true })
				end, "LSP: Trouble Next")
				nmap("[d", function()
					local trouble = require("trouble")
					trouble.open("workspace_diagnostics")
					trouble.previous({ skip_groups = true, jump = true })
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
				nmap("<leader>f", function()
					vim.lsp.buf.format({ async = true })
				end, "[F]ormat")
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
				"bashls",
				"clangd",
				"cmake",
				"cssls",
				"emmet_ls",
				"html",
				"jedi_language_server",
				"jsonls",
				"lua_ls",
				"tailwindcss",
				"texlab",
				"tsserver",
			},
			handlers = {
				default_setup,
				clangd = function()
					lsp_capabilities.offsetEncoding = { "utf-16" }
					vim.api.nvim_create_autocmd("LspAttach", {
						desc = "Enable Inlay Hints",
						callback = function()
							require("clangd_extensions.inlay_hints").setup_autocmd()
							require("clangd_extensions.inlay_hints").set_inlay_hints()
						end,
					})
					require("plugins.lsp.c").setup(lsp, lsp_capabilities)
				end,
				bashls = function()
					require("plugins.lsp.bash").setup(lsp, lsp_capabilities)
				end,
				emmet_ls = function()
					require("plugins.lsp.emmet").setup(lsp, lsp_capabilities)
				end,
				texlab = function()
					require("plugins.lsp.tex").setup(lsp, lsp_capabilities)
				end,
				lua_ls = function()
					require("plugins.lsp.lua").setup(lsp, lsp_capabilities)
				end,
				htmx = function()
					local opts = {
						filetypes = { "html", "htmldjango" },
					}
					require("lspconfig").htmx.setup(opts)
				end,
			},
		})
	end,
}
