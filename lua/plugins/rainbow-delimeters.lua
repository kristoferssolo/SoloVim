return {
	"HiPhish/rainbow-delimiters.nvim",
	opts = {
		strategy = {},
		query = {},
		highlight = {},
	},
	config = function(_, opts)
		require("rainbow-delimiters.setup").setup(opts)
	end,
}
