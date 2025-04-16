return {
	"HakonHarnes/img-clip.nvim",
	event = "VeryLazy",
	keys = {
		{ "<leader>v", vim.cmd.PasteImage, desc = "Paste image from system clipboard" },
	},
	opts = {
		default = {
			dir_path = "assets/img",
			extension = "webp",
			process_cmd = "convert - -quality 75 webp:-",
			file_name = "%Y-%m-%d-%H%M%S",
			relative_to_current_file = false,
			prompt_for_file_name = false,
		},
		filetypes = {
			markdown = {
				template = "![[$FILE_PATH]]",
			},
			vimwiki = {
				template = "![[$FILE_PATH]]",
			},
		},
	},
}
