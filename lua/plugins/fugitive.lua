return {
	"tpope/vim-fugitive",
	lazy = false,
	keys = {
		{ "<leader>gg", vim.cmd.G, desc = "[G]it" },
		{ "<leader>gd", vim.cmd.Gdiffsplit, desc = "[G]it [D]iff" },
	},
}
