return {
	"mrcjkb/rustaceanvim",
	version = "^5",
	lazy = false,
	opts = {
		tools = {
			hover_actions = {
				replace_builtin_hover = false,
			},
		},
		server = {
			on_attach = function(_, bufnr)
				vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
			end,
			settings = {
				["rust-analyzer"] = {
					--- https://rust-analyzer.github.io/book/configuration.html
					cargo = {
						features = "all",
						extraEnv = { RUSTC_WRAPPER = "sccache" },
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
					procMacro = {
						ignored = {
							leptos_macro = {
								"server",
							},
						},
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
