return {
	"simrat39/inlay-hints.nvim",
	opts = {
		hints = {
			parameter = {
				show = true,
				highlight = "Comment",
			},
			type = {
				show = true,
				highlight = "Comment",
			},
		},
		only_current_line = true,

		eol = {
			-- whether to align to the extreme right or not
			right_align = false,

			-- padding from the right if right_align is true
			right_align_padding = 7,

			parameter = {
				separator = ", ",
				format = function(hints)
					return string.format(" <- (%s)", hints)
				end,
			},

			type = {
				separator = ", ",
				format = function(hints)
					return string.format(" => (%s)", hints)
				end,
			},
		},
	},
}
