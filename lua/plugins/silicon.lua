return {
	"michaelrommel/nvim-silicon",
	lazy = true,
	main = "nvim-silicon",
	cmd = "Silicon",
	opts = {
		font = "JetBrainsMono NF=34",
		theme = "Rosé Pine",
		background = "#1f1d2e",
		no_window_controls = true,
		line_offset = function(args)
			return args.line1
		end,
		language = function()
			return vim.bo.filetype
		end,
		shadow_color = "#191724",
		output = function()
			return "~/Pictures/screenshots/code/" .. os.date("!%Y_%m_%d-%H_%M_%S") .. ".png"
		end,
		to_clipboard = true,
		window_title = function()
			return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), ":t")
		end,
	},
}
