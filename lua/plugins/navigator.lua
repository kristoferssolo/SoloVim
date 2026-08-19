return {
	"numToStr/Navigator.nvim",
	opts = {},
	keys = {
		{ "<C-h>", vim.cmd.NavigatorLeft, desc = "Focus window left", mode = { "n", "t" } },
		{ "<C-j>", vim.cmd.NavigatorDown, desc = "Focus window down", mode = { "n", "t" } },
		{ "<C-k>", vim.cmd.NavigatorUp, desc = "Focus window up", mode = { "n", "t" } },
		{ "<C-l>", vim.cmd.NavigatorRight, desc = "Focus window right", mode = { "n", "t" } },
		{ "<C-\\>", vim.cmd.NavigatorPrevious, desc = "Focus window previous", mode = { "n", "t" } },
	},
}
