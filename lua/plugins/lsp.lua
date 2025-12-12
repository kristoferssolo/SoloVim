return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"mason-org/mason.nvim",
		"mason-org/mason-lspconfig.nvim",
		"saghen/blink.cmp",
		"folke/snacks.nvim",
		"folke/trouble.nvim",
		"folke/neoconf.nvim",
		"mrcjkb/rustaceanvim",
		"pmizio/typescript-tools.nvim",
	},
	config = function(_, opts)
		require("mason").setup()

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

		local default_setup = function(server)
			local server_config = opts.servers[server]
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			local final_config = {}
			if server_config then
				-- Deep extend custom config with default capabilities
				final_config = vim.tbl_deep_extend("force", {}, server_config, {
					capabilities = extend_capabilities(capabilities),
				})
			else
				-- Basic setup with default capabilities if no custom config exists
				final_config = {
					capabilities = extend_capabilities(capabilities),
				}
			end

			vim.lsp.config(server, final_config)
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
					trouble.next({ mode = "diagnostics", skip_groups = true, jump = true })
				end, "LSP: Trouble Next")
				nmap("[d", function()
					trouble.prev({ mode = "diagnostics", skip_groups = true, jump = true })
				end, "Trouble Prev")
				vim.keymap.set(
					{ "n", "v", "x" },
					"<leader>la",
					vim.lsp.buf.code_action,
					{ buffer = event.buf, desc = "LSP: Code [A]ction" }
				)
				nmap("gr", function()
					trouble.toggle("lsp_references")
				end, "[G]oto [R]eferences")
				nmap("gR", function()
					Snacks.picker.lsp_references()
				end, "[G]oto [R]eferences")
			end,
		})

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

		require("mason-lspconfig").setup({
			automatic_installation = true,
			automatic_setup = true,
			automatic_enable = true,
			ensure_installed = {
				"basedpyright",
				"bashls",
				"clangd",
				"cssls",
				"css_variables",
				"emmet_language_server",
				"gopls",
				"html",
				"hyprls",
				"jinja_lsp",
				"jsonls",
				"lua_ls",
				"markdown_oxide",
				"neocmake",
				"ruff",
				-- "somesass_ls",
				"tailwindcss",
				"tinymist",
				"ts_ls",
			},
			handlers = {
				default_setup,
				ts_ls = function() end,
			},
		})

		local function setup_ghostty_lsp()
			-- Only activate ghostty-lsp when editing the ghostty config
			if vim.fn.expand("%:p") == vim.fs.normalize("**/ghostty/config") then
				vim.lsp.start({
					name = "ghostty-lsp",
					cmd = { "ghostty-lsp" },
					root_dir = vim.fs.normalize("~/.config/ghostty"),
				})
			end
		end

		vim.api.nvim_create_autocmd("BufRead", { pattern = "*", callback = setup_ghostty_lsp })
	end,

	opts = {
		servers = {
			gopls = {
				settings = {
					hints = {
						rangeVariableTypes = true,
						parameterNames = true,
						constantValues = true,
						assignVariableTypes = true,
						compositeLiteralFields = true,
						compositeLiteralTypes = true,
						functionTypeParameters = true,
					},
				},
			},
			lua_ls = {
				settings = {
					Lua = {
						diagnostics = {
							globals = {
								"vim",
								"awesome",
								"client",
								"s",
								"sn",
								"isn",
								"t",
								"i",
								"f",
								"c",
								"d",
								"r",
								"events",
								"k",
								"ai",
								"extras",
								"l",
								"rep",
								"p",
								"m",
								"n",
								"dl",
								"fmt",
								"fmta",
								"conds",
								"postfix",
								"types",
								"parse",
								"ms",
							},
						},
						telemetry = { enable = false },
						format = { enable = true },
						hint = { enable = true },
					},
				},
			},
			clangd = {
				capabilities = {
					offsetEncoding = { "utf-16" },
				},
				settings = {
					clangd = {
						InlayHints = {
							Designators = true,
							Enabled = true,
							ParameterNames = true,
							DeducedTypes = true,
						},
						fallbackFlags = { "-std=c++20" },
					},
				},
			},
			bashls = {
				filetypes = {
					"sh",
					"bash",
					"zsh",
				},
			},
			tailwindcss = {
				filetypes = {
					"aspnetcorerazor",
					"astro",
					"astro-markdown",
					"blade",
					"clojure",
					"django-html",
					"htmldjango",
					"edge",
					"eelixir",
					"elixir",
					"ejs",
					"erb",
					"eruby",
					"gohtml",
					"gohtmltmpl",
					"haml",
					"handlebars",
					"hbs",
					"html",
					"htmlangular",
					"html-eex",
					"heex",
					"jade",
					"leaf",
					"liquid",
					"mdx",
					"mustache",
					"njk",
					"nunjucks",
					"php",
					"razor",
					"slim",
					"twig",
					"css",
					"less",
					"postcss",
					"sass",
					"scss",
					"stylus",
					"sugarss",
					"javascript",
					"javascriptreact",
					"reason",
					"rescript",
					"typescript",
					"typescriptreact",
					"vue",
					"svelte",
					"templ",
				},
			},
			texlab = {
				texlab = {
					auxDirectory = ".",
					bibtexFormatter = "texlab",
					build = {
						args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
						executable = "xelatex",
						forwardSearchAfter = false,
						onSave = false,
					},
					chktex = {
						onEdit = false,
						onOpenAndSave = false,
					},
					diagnosticsDelay = 0,
					formatterLineLength = 120,
					forwardSearch = {
						args = {},
					},
					latexFormatter = "latexindent",
					latexindent = {
						modifyLineBreaks = false,
					},
				},
			},
			-- htmx = {
			-- 	filetypes = { "html", "htmldjango", "templ" },
			-- },
			basedpyright = {
				typeCheckingMode = "off",
				analysis = {
					autoSearchPaths = true,
					diagnosticMode = "openFilesOnly",
					useLibraryCodeForTypes = true,
					disableOrganizeImports = true,
					diagnosticSeverityOverrides = {
						reportUnusedVariable = "none",
						reportUndefinedVariable = "warning",
					},
				},
			},
			jinja_lsp = {
				filetypes = { "html", "htmldjango", "templ" },
			},
			emmet_language_server = {
				filetypes = {
					"astro",
					"css",
					"eruby",
					"html",
					"htmlangular",
					"htmldjango",
					"javascriptreact",
					"less",
					"pug",
					"sass",
					"scss",
					"svelte",
					"templ",
					"typescriptreact",
					"vue",
					"rust",
				},
			},
			html = {
				filetypes = {
					"html",
					"htmldjango",
					"templ",
				},
				init_options = {
					provideFormatter = false,
				},
			},
			tinymist = {
				offset_encoding = "utf-8",
				settings = {
					formatterMode = "typstyle",
					exportPdf = "none",
					outputPath = "$root/target/$dir/$name",
					semanticTokens = "disable",
				},
			},
			markdown_oxide = {
				capabilities = {
					workspace = {
						didChangeWatchedFiles = {
							dynamicRegistration = true,
						},
					},
				},
			},
			jsonls = {
				filetypes = {
					"json",
					"jsonc",
					"json5",
				},
			},
			kulala_ls = {},
		},
	},
}
