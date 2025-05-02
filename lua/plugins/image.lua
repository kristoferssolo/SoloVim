local function is_typst()
	return vim.bo.filetype == "typst"
end
return {
	"HakonHarnes/img-clip.nvim",
	event = "VeryLazy",
	keys = {
		{ "<leader>v", vim.cmd.PasteImage, desc = "Paste image from system clipboard" },
	},
	opts = {
		default = {
			dir_path = "assets/img",
			extension = function()
				if is_typst() then
					return "png"
				else
					return "webp"
				end
			end,
			process_cmd = function()
				if is_typst() then
					return ""
				else
					return "convert - -quality 75 webp:-"
				end
			end,
			file_name = "%Y-%m-%d_%H-%M-%S",
			relative_to_current_file = false,
			prompt_for_file_name = function()
				return is_typst()
			end,
			embed_image_as_base64 = false,
			drag_and_drop = {
				insert_mode = true,
			},
		},
		filetypes = {
			markdown = {
				template = "![[$FILE_PATH]]",
			},
			vimwiki = {
				template = "![[$FILE_PATH]]",
			},
			typst = {
				template = [[
#figure(
  image("$FILE_PATH", width: 80%),
  caption: [$CURSOR],
) <$LABEL>
    ]],
			},
		},
	},
}
