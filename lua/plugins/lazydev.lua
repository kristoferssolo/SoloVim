return {
	"folke/lazydev.nvim",
	ft = "lua",
	opts = {
		library = {
			"~/repos/lualine-harpoon.nvim",
			"~/Nextcloud/repos/jsonl.nvim",
			{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
		},
	},
}
