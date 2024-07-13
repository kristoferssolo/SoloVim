return {
	"jellydn/typecheck.nvim",
	dependencies = { "folke/trouble.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
	ft = { "javascript", "javascriptreact", "json", "jsonc", "typescript", "typescriptreact" },
	opts = {
		debug = true,
		mode = "trouble", -- "quickfix" | "trouble"
	},
	keys = {
		{
			"<leader>lt",
			vim.cmd.Typecheck,
			desc = "Run Type Check",
			ft = { "javascript", "javascriptreact", "json", "jsonc", "typescript", "typescriptreact" },
		},
	},
}
