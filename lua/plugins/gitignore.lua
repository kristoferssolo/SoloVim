return {
	"wintermute-cell/gitignore.nvim",
	dependencies = {},
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
	config = function()
		require("gitignore")
	end,
}
