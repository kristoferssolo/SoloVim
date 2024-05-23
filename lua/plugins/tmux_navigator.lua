return {
	"christoomey/vim-tmux-navigator",
	cmd = {
		"TmuxNavigateLeft",
		"TmuxNavigateDown",
		"TmuxNavigateUp",
		"TmuxNavigateRight",
		"TmuxNavigatePrevious",
	},
	keys = {
		{ "<C-h>", vim.cmd.TmuxNavigateLeft, desc = "Focus window left", mode = { "n", "t" } },
		{ "<C-j>", vim.cmd.TmuxNavigateDown, desc = "Focus window down", mode = { "n", "t" } },
		{ "<C-k>", vim.cmd.TmuxNavigateUp, desc = "Focus window up", mode = { "n", "t" } },
		{ "<C-l>", vim.cmd.TmuxNavigateRight, desc = "Focus window right", mode = { "n", "t" } },
		{ "<C-\\>", vim.cmd.TmuxNavigatePrevious, desc = "Focus window previous", mode = { "n", "t" } },
	},
}
