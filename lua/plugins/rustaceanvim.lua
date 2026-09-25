return {
	"mrcjkb/rustaceanvim",
	version = "^9",
	lazy = false,
	opts = {
		tools = {
			hover_actions = {
				replace_builtin_hover = false,
			},
		},
		server = {
			on_attach = function(client, bufnr)
				vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })

				--- Match Zed's default: Tree-sitter highlighting, no LSP semantic tokens.
				-- vim.lsp.semantic_tokens.enable(false, {
				-- 	bufnr = bufnr,
				-- 	client_id = client.id,
				-- })
			end,
			default_settings = {
				["rust-analyzer"] = {
					--- https://rust-analyzer.github.io/book/configuration.html
					numThreads = "logical",
					cachePriming = {
						numThreads = "logical",
					},
					cargo = {
						-- features = "all",
					},
					procMacro = {
						processed = 4,
					},
					-- Keep RA's semantic analysis, but don't automatically run
					-- cargo/clippy over a giant workspace whenever a file is saved.
					-- checkOnSave = false,
					check = {
						-- features = "all",
						command = "clippy",
					},
					completion = {
						fullFunctionSignatures = { enable = true },
						termSearch = { enable = true },
						privateEditable = { enable = true },
					},
					diagnostics = {
						styleLints = { enable = true },
					},
					inlayHints = {
						bindingModeHints = { enable = true },
						closureCaptureHints = { enable = true },
						closureReturnTypeHints = { enable = "always" },
						discriminantHints = { enable = "always" },
						rangeExclusiveHints = { enable = true },
					},
					semanticHighlighting = {
						strings = { enable = false },
					},
				},
			},
		},

		dap = {},
	},
	config = function(_, opts)
		vim.g.rustaceanvim = opts
	end,
}
