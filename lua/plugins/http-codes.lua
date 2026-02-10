return {
	"barrettruth/http-codes.nvim",
	dependencies = "folke/snacks.nvim",
	cmd = "HTTPCodes",
	keys = { { "<leader>pH", vim.cmd.HTTPCodes, desc = "HTTP" } },
	opts = {
		use = "snacks",
	},
}
