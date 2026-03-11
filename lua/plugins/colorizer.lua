return {
	"catgoose/nvim-colorizer.lua",
	event = "BufReadPre",
	opts = {
		options = {
			parsers = {
				css = true,
				names = false,
				css_fn = true,
				tailwind = { enable = true, lsp = true, update_name = true },
				sass = { enable = true, parsers = { css = true } },
			},
		},
	},
}
