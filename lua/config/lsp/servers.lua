return {
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
						"Snacks",
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
	hyprls = {
		filetypes = { "hyprlang" },
		root_dir = function(bufnr, on_dir)
			local path = bufnr
			if type(bufnr) == "number" then
				path = vim.api.nvim_buf_get_name(bufnr)
			end
			if type(path) ~= "string" or path == "" then
				return
			end

			on_dir(vim.fs.dirname(path))
		end,
		single_file_support = true,
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
			-- "rust",
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
}
