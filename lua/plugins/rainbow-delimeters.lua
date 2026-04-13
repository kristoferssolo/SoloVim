return {
	"HiPhish/rainbow-delimiters.nvim",
	submodules = false,
	opts = {},
	config = function(_, opts)
		require("rainbow-delimiters.setup").setup(opts)
	end,
}
