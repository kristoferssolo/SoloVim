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
	opts = {},
}
