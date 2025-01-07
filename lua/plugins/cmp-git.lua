return {
	"petertriho/cmp-git",
	dependencies = { "nvim-lua/plenary.nvim" },
	ft = { "gitcommit", "octo", "NeogitCommitMessage" },
	opts = {
		gitlab = {
			hosts = {
				"git.modulation.lv",
			},
		},
	},
	config = function(_, opts)
		require("cmp_git").setup(opts)
	end,
}
