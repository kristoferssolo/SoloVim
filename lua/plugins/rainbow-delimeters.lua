return {
	"HiPhish/rainbow-delimiters.nvim",
	submodules = false,
	opts = {
		strategy = {},
		query = {},
		highlight = {},
	},
	config = function(_, opts)
		require("rainbow-delimiters.setup").setup(opts)
	end,
}
