return {
	"mrcjkb/rustaceanvim",
	version = "^4", -- Recommended
	lazy = false, -- This plugin is already lazy
	enabled = false,
	config = function()
		vim.g.rustaceanvim = {
			server = {
				settings = {
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
		}
	end,
}
