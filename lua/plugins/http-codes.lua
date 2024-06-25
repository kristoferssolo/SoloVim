return {
	"barrett-ruth/http-codes.nvim",
	dependencies = { "nvim-telescope/telescope.nvim" },
	keys = { { "<leader>pdh", vim.cmd.HTTPCodes, desc = "[H]TTP" } },
	config = true,
}
