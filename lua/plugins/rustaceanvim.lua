return {
	"mrcjkb/rustaceanvim",
	version = "^5",
	lazy = false,
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
							enable = "never",
							useParameterNames = false,
						},
						maxLength = 25,
						parameterHints = {
							enable = true,
						},
						reborrowHints = {
							enable = "never",
						},
						renderColons = true,
						typeHints = {
							enable = true,
							hideClosureInitialization = false,
							hideNamedConstructor = false,
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
