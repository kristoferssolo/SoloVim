return {
	"wintermute-cell/gitignore.nvim",
	cmd = { "Gitignore" },
	keys = {
		{
			"<leader>gi",
			function()
				require("gitignore").generate({})
			end,
			desc = "Git Ignore",
		},
	},
}
