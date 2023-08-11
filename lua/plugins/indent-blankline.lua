return {
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			vim.opt.list = true
			vim.opt.listchars:append("space:⋅")
			vim.opt.listchars:append("eol:↴")

			require("indent_blankline").setup({
				char = "▎",
				show_trailing_blankline_indent = true,
				show_first_indent_level = true,
				use_treesitter = true,
				show_end_of_line = true,
				space_char_blankline = " ",
				show_current_context = true,
				show_current_context_start = false,
				buftype_exclude = { "terminal", "nofile" },
				filetype_exclude = {
					"NvimTree",
					"Trouble",
					"alpha",
					"dashboard",
					"help",
					"lazy",
					"neogitstatus",
					"packer",
					"startify",
				},
			})
		end,
	},
}
