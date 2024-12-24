return {
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
					runtime = {
						-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
						version = "LuaJIT",
					},
					diagnostics = {
						-- Get the language server to recognize the `vim` global
						globals = { "vim", "awesome", "client" },
					},
					-- workspace = {
					-- Make the server aware of Neovim runtime files
					-- library = vim.api.nvim_get_runtime_file("", true),
					-- },
					-- Do not send telemetry data containing a randomized but unique identifier
					telemetry = {
						enable = false,
					},
					root_pattern = {
						".stylua.toml",
						".luarc.json",
						".luarc.jsonc",
						".luacheckrc",
						"stylua.toml",
						"selene.toml",
						"selene.yml",
						".git",
					},
					format = {
						enable = false,
					},
					hint = {
						enable = true,
					},
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
		emmet_ls = {
			filetypes = {
				"html",
				"htmldjango",
				"typescriptreact",
				"javascriptreact",
				"css",
				"sass",
				"scss",
				"less",
				"eruby",
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
		htmx = {
			filetypes = { "html", "htmldjango", "templ" },
		},
		--[[ pylyzer = {
		settings = {
			python = {
				diagnostics = true,
				inlayHints = true,
				smartCompletion = true,
				checkOnType = true,
			},
		},
	}, ]]
		--[[ basedpyright = {
		basedpyright = {
			analysis = {
				autoSearchPaths = true,
				diagnosticMode = "openFilesOnly",
				useLibraryCodeForTypes = true,
			},
		},
	}, ]]
		--[[ pylsp = {
			settings = {
				pylsp = {
					plugins = {
						autopep8 = { enabled = false },
						flake8 = { enabled = false },
						pylint = { enabled = false },
						yapf = { enabled = false },
						pydocstyle = { enabled = false },
						mccabe = { enabled = false },
						rope_autoimport = { enabled = true },
						rope_completion = {
							enabled = true,
							eager = true,
						},
						pycodestyle = {
							maxLineLength = nil,
						},
					},
				},
			},
		}, ]]
		jinja_lsp = {
			filetypes = { "html", "htmldjango", "templ" },
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
				exportPdf = "onType",
				outputPath = "$root/target/$dir/$name",
			},
		},
		ts_ls = {},
	},
}
