return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"folke/neodev.nvim",
		"nvim-telescope/telescope.nvim",
	},
	keys = {
		{
			"<leader>la",
			vim.lsp.buf.code_action,
			desc = "Code [A]ction",
		},
		{
			"<leader>lD",
			vim.lsp.buf.type_definition,
			desc = "Type [D]efinitions",
		},
		{
			"<leader>lf",
			function()
				vim.lsp.buf.format({ async = true })
			end,
			desc = "[F]ormat",
		},
		{
			"<leader>lo",
			vim.diagnostic.open_float,
			desc = "[O]pen Float",
		},
		{
			"<leader>ls",
			vim.diagnostic.setloclist,
			desc = "[S]etloclist",
		},
		{
			"<leader>lr",
			vim.lsp.buf.rename,
			desc = "[R]ename",
		},
		{
			"<leader>lds",
			require("telescope.builtin").lsp_document_symbols,
			desc = "[D]ocument [S]ymbols",
		},
		{
			"<leader>lwd",
			require("telescope.builtin").diagnostics,
			desc = "[W]orkspace [D]iagnostics",
		},
		{
			"<leader>lws",
			require("telescope.builtin").lsp_dynamic_workspace_symbols,
			desc = "[W]orkspace [S]ymbols",
		},
		{
			"<leader>lwa",
			vim.lsp.buf.add_workspace_folder,
			desc = "[W]orkspace [A]dd Folder",
		},
		{
			"<leader>lwr",
			vim.lsp.buf.remove_workspace_folder,
			desc = "[W]orkspace [R]emove Folder",
		},
		{
			"<leader>lwl",
			function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end,
			desc = "[W]orkspace [L]ist Folder",
		},
		{
			"<leader>lq",
			require("telescope.builtin").quickfix,
			desc = "Telescope [Q]uickfix",
		},
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

				nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
				nmap("gr", function()
					require("trouble").toggle("lsp_references")
				end, "[G]oto [R]eferences")
				nmap("gR", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
				nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
				nmap("K", vim.lsp.buf.hover, "Hover Documentation")
				-- nmap("<C-K>", vim.lsp.buf.signature_help, "Signature Documentation")
				nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
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

		local config = {
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
		}

		vim.diagnostic.config(config)

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
				"taplo",
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
				typst_lsp = function()
					require("plugins.lsp.typst").setup(lsp, lsp_capabilities)
				end,
				lua_ls = function()
					require("plugins.lsp.lua").setup(lsp, lsp_capabilities)
				end,
			},
		})
	end,
}
