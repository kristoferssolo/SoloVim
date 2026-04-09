local M = {}

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

function M.defaults(server_config)
	local capabilities = require("blink.cmp").get_lsp_capabilities()

	return vim.tbl_deep_extend("force", {
		capabilities = extend_capabilities(capabilities),
	}, server_config or {})
end

function M.setup_diagnostics()
	vim.diagnostic.config({
		virtual_text = true,
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = "",
				[vim.diagnostic.severity.WARN] = "",
				[vim.diagnostic.severity.HINT] = "",
				[vim.diagnostic.severity.INFO] = "",
			},
		},
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
end

function M.setup_attach()
	vim.api.nvim_create_autocmd("LspAttach", {
		desc = "LSP actions",
		callback = function(event)
			local nmap = function(keys, func, desc)
				if desc then
					desc = "LSP: " .. desc
				end
				vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
			end
			local trouble = nil

			nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
			nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
			nmap("K", function()
				vim.lsp.buf.hover({ border = "rounded" })
			end, "Hover Documentation")
			nmap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
			vim.keymap.set("i", "<C-H>", function()
				vim.lsp.buf.signature_help({ border = "rounded" })
			end, { buffer = event.buf, desc = "LSP: Signature Documentation" })
			nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
			nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
			nmap("<leader>ws", vim.lsp.buf.workspace_symbol, "[W]orkspace [S]ymbol")
			nmap("<leader>wd", vim.diagnostic.open_float, "[W]orkspace [D]iagnostic")
			nmap("<leader>wl", function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, "[W]orkspace [L]ist Folders")
			nmap("<leader>lD", vim.lsp.buf.type_definition, "Type [D]efinition")
			nmap("<leader>lr", vim.lsp.buf.rename, "[R]ename")
			nmap("<leader>lj", function()
				vim.diagnostic.jump({ count = 1, float = true })
			end, "Diagnostic Next")
			nmap("<leader>lk", function()
				vim.diagnostic.jump({ count = -1, float = true })
			end, "Diagnostic Prev")
			nmap("]d", function()
				trouble = trouble or require("trouble")
				trouble.next({ mode = "diagnostics", skip_groups = true, jump = true })
			end, "LSP: Trouble Next")
			nmap("[d", function()
				trouble = trouble or require("trouble")
				trouble.prev({ mode = "diagnostics", skip_groups = true, jump = true })
			end, "Trouble Prev")
			vim.keymap.set(
				{ "n", "v", "x" },
				"<leader>la",
				vim.lsp.buf.code_action,
				{ buffer = event.buf, desc = "LSP: Code [A]ction" }
			)
			nmap("gr", function()
				trouble = trouble or require("trouble")
				trouble.toggle("lsp_references")
			end, "[G]oto [R]eferences")
			nmap("gR", function()
				Snacks.picker.lsp_references()
			end, "[G]oto [R]eferences")
		end,
	})
end

return M
