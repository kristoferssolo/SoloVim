local function is_typst()
	return vim.bo.filetype == "typst"
end
return {
	{
		"3rd/image.nvim",
		opts = {
			backend = "ueberzug",
			processor = "magick_rock",
			scale_factor = 0.5,
			integrations = {
				neorg = {
					clear_in_insert_mode = true,
					only_render_image_at_cursor = true,
					only_render_image_at_cursor_mode = "popup",
				},
				typst = {
					enabled = false,
					clear_in_insert_mode = true,
					only_render_image_at_cursor = true,
					only_render_image_at_cursor_mode = "popup",
				},
				markdown = {
					clear_in_insert_mode = true,
					only_render_image_at_cursor = true,
					only_render_image_at_cursor_mode = "popup",
					resolve_image_path = function(document_path, image_path, fallback)
						local working_dir = vim.fn.getcwd()
						if working_dir:find("Obsidian") then
							return working_dir .. "/assets/img/" .. image_path
						end
						return fallback(document_path, image_path)
					end,
				},
			},
		},
	},
	{
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
				prompt_for_file_name = is_typst,
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
	},
}
