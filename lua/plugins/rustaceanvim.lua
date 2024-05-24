return {
	"mrcjkb/rustaceanvim",
	version = "^4",
	lazy = false,
	ft = { "rust" },
	opts = {
		tools = {},
		server = {
			settings = {
				-- on_attach = function(client, bufnr)
				-- 	-- you can also put keymaps in here
				-- end,
				["rust-analyzer"] = {
					inlayHints = {
						bindingModeHints = {
							enable = false,
						},
						chainingHints = {
							enable = true,
						},
						closingBraceHints = {
							enable = true,
							minLines = 25,
						},
						closureReturnTypeHints = {
							enable = true,
						},
						lifetimeElisionHints = {
							enable = true,
							useParameterNames = true,
						},
						maxLength = 25,
						parameterHints = {
							enable = true,
						},
						reborrowHints = {
							enable = true,
						},
						renderColons = true,
						typeHints = {
							enable = true,
							hideClosureInitialization = true,
							hideNamedConstructor = true,
						},
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
