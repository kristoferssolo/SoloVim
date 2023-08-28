if not pcall(require, "obsidian") then
	return
end

require("obsidian").setup({
	dir = "~/obsidian",
	notes_subdir = "university",

	completion = {
		nvim_cmp = true,
		min_chars = 2,
		new_notes_location = "current_dir",
		prepend_note_id = true,
	},

	mappings = {
		["gf"] = require("obsidian.mapping").gf_passthrough(),
	},

	templates = {
		subdir = "university/templates",
		date_format = "%Y.%m.%d",
		time_format = "%H:%M:%S",
	},

	backlinks = {
		height = 10,
		wrap = true,
	},

	follow_url_func = function(url)
		vim.fn.jobstart({ "xdg-open", url })
	end,
	use_advanced_uri = true,
	open_app_foreground = false,
	open_notes_in = "current",
})
