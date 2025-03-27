return {
	"3rd/image.nvim",
	opts = {
		backend = "ueberzug", -- ueberzug, kitty
		processor = "magick_rock", -- or "magick_cli"
		integrations = {
			markdown = {
				enabled = true,
				clear_in_insert_mode = false,
				download_remote_images = true,
				only_render_image_at_cursor = true,
				filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
			},
			neorg = {
				enabled = true,
				only_render_image_at_cursor = true,
				filetypes = { "norg" },
			},
			typst = {
				enabled = true,
				only_render_image_at_cursor = true,
				filetypes = { "typst" },
			},
			html = {
				enabled = true,
				only_render_image_at_cursor = true,
			},
			css = {
				enabled = true,
				only_render_image_at_cursor = true,
			},
		},
		max_width = nil,
		max_height = nil,
		max_width_window_percentage = nil,
		max_height_window_percentage = 50,
		window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
		window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
		editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
		tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
		hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- render image files as images when opened
		resolve_image_path = function(document_path, image_path, fallback)
			-- Define the absolute path to your Assets directory
			local assets_dir = vim.fn.expand("~/Obsidian/assets/img/")

			-- Check if the image_path is already an absolute path
			if image_path:match("^/") then
				-- If it's an absolute path, leave it unchanged
				return image_path
			end

			-- Construct the new image path by prepending the Assets directory
			local new_image_path = assets_dir .. "/" .. image_path

			-- Check if the constructed path exists
			if vim.fn.filereadable(new_image_path) == 1 then
				return new_image_path
			else
				-- If the file doesn't exist in Assets, fallback to default behavior
				return fallback(document_path, image_path)
			end
		end,
	},
}
