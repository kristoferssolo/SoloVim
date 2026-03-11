return {
	"gisketch/triforce.nvim",
	dependencies = { "nvzone/volt" },
	config = function()
		require("triforce").setup()
	end,
}
