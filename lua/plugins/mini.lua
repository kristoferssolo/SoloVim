return {
	"echasnovski/mini.nvim",
	version = "*",
	opts = {
		enabled = {
			"ai",
			-- "pairs",
			"splitjoin",
			"surround",
			"diff",
		},
	},
	config = function(_, opts)
		for _, value in ipairs(opts.enabled) do
			require("mini." .. value).setup()
		end
	end,
}
