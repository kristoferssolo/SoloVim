return {
	"chomosuke/typst-preview.nvim",
	ft = "typst",
	version = "*",
	keys = {
		{ "<leader>ot", vim.cmd.TypstPreviewToggle, desc = "Toggle Typst Preview" },
	},
	cmd = {
		"TypstPreviewUpdate",
		"TypstPreview",
		"TypstPreviewStop",
		"TypstPreviewToggle",
		"TypstPreviewFollowCursor",
		"TypstPreviewNoFollowCursor",
		"TypstPreviewFollowCursorToggle",
		"TypstPreviewSyncCursor",
	},
	build = function()
		require("typst-preview").update()
	end,
	opts = {
		-- Setting this true will enable printing debug information with print()
		debug = false,

		-- Custom format string to open the output link provided with %s
		-- Example: open_cmd = 'firefox %s -P typst-preview --class typst-preview'
		open_cmd = "xdg-open %s",
		-- open_cmd = "floorp %s -P typst-preview --class typst-preview",

		-- Setting this to 'always' will invert black and white in the preview
		-- Setting this to 'auto' will invert depending if the browser has enable
		-- dark mode
		invert_colors = nil,
		-- Whether the preview will follow the cursor in the source file
		follow_cursor = true,

		-- Provide the path to binaries for dependencies.
		-- Setting this will skip the download of the binary by the plugin.
		-- Warning: Be aware that your version might be older than the one
		-- required.
		dependencies_bin = {
			-- if you are using tinymist, just set ['typst-preview'] = "tinymist".
			["typst-preview"] = nil,
			["websocat"] = nil,
		},
		-- A list of extra arguments (or nil) to be passed to previewer.
		-- For example, extra_args = { "--input=ver=draft", "--ignore-system-fonts" }
		extra_args = nil,
		-- This function will be called to determine the root of the typst project
		get_root = function(path_of_main_file)
			return vim.fn.fnamemodify(path_of_main_file, ":p:h")
		end,

		-- This function will be called to determine the main file of the typst
		-- project.
		get_main_file = function(path_of_buffer)
			return path_of_buffer
		end,
	},
}
