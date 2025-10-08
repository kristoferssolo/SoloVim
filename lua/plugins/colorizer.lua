return {
	"catgoose/nvim-colorizer.lua",
	event = "BufReadPre",
	opts = {
		user_default_options = {
			names = false,
			css = true,
			css_fn = true,
			tailwind = true,
			tailwind_opts = {
				update_names = true,
			},
			sass = { enable = true, parsers = { "css" } },
		},
	},
}
