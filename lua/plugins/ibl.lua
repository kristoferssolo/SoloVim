return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	version = "3.5.0",
	opts = {
		enabled = true,
		indent = {
			smart_indent_cap = true,
		},
		whitespace = {
			remove_blankline_trail = true,
		},
		scope = {
			show_start = true,
			show_end = true,
			show_exact_scope = true,
		},
		exclude = {
			filetypes = {
				"NvimTree",
				"Trouble",
				"alpha",
				"dashboard",
				"help",
				"lazy",
				"neogitstatus",
				"packer",
				"startify",
				"lspinfo",
			},
			buftypes = {
				"terminal",
				"nofile",
				"quickfix",
				"prompt",
			},
		},
	},
}
