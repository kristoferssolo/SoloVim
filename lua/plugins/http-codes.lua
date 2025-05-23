return {
	"barrett-ruth/http-codes.nvim",
	dependencies = { "nvim-telescope/telescope.nvim" },
	keys = { { "<leader>pdh", vim.cmd.HTTPCodes, desc = "HTTP" } },
	config = true,
}
