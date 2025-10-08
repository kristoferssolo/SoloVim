return {
	"barrett-ruth/http-codes.nvim",
	dependencies = { "folke/snacks.nvim" },
	cmd = "HTTPCodes",
	keys = { { "<leader>pdh", vim.cmd.HTTPCodes, desc = "HTTP" } },
	config = true,
}
