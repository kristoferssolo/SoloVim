return {
	"esmuellert/codediff.nvim",
	cmd = "CodeDiff",
	keys = {
		{
			"<leader>gD",
			vim.cmd.CodeDiff,
			desc = "Git CodeDiff",
		},
	},
}
