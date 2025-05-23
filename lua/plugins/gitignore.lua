return {
	"wintermute-cell/gitignore.nvim",
	dependencies = { "nvim-telescope/telescope.nvim" },
	cmd = { "Gitignore" },
	keys = {
		{
			"<leader>gi",
			function()
				require("gitignore").generate()
			end,
			desc = "Git Ignore",
		},
	},
	config = function()
		require("gitignore")
	end,
}
