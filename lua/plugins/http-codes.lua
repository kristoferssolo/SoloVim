return {
	"kristoferssolo/http-codes.nvim",
	branch = "feature/snacks",
	dependencies = "folke/snacks.nvim",
	cmd = "HTTPCodes",
	keys = { { "<leader>pH", vim.cmd.HTTPCodes, desc = "HTTP" } },
	opts = {
		use = "snacks",
	},
}
