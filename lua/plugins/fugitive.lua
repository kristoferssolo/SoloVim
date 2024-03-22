return {
	"tpope/vim-fugitive",
	lazy = false,
	enabled = false,
	keys = {
		{ "<leader>gg", vim.cmd.G, desc = "[G]it" },
		{ "<leader>gd", vim.cmd.Gdiffsplit, desc = "[G]it [D]iff" },
		{
			"<leader>gh",
			function()
				vim.cmd.diffget("//2")
			end,
			desc = "[G]it Select Left",
		},
		{
			"<leader>gl",
			function()
				vim.cmd.diffget("//3")
			end,
			desc = "[G]it Select Right",
		},
		{
			"<leader>gp",
			function()
				vim.cmd.Git("pull --rebase")
			end,
			desc = "[G]it [P]ull",
		},
		{
			"<leader>gP",
			function()
				vim.cmd.Git("push -u origin")
			end,
			desc = "[G]it [P]ush",
		},
	},
}
