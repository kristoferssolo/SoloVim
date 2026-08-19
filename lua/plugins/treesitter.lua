return {
	"romus204/tree-sitter-manager.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
	},
	opts = {
		ensure_installed = {
			"git_config",
			"git_rebase",
			"gitattributes",
			"gitcommit",
			"gitignore",
			"http",
			"json",
			"lua",
			"markdown",
			"python",
			"rust",
			"sql",
		},
		border = "rounded",
		auto_install = true,
		highlight = true,
		languages = {},
	},
	-- config = function(_, opts)
	-- 	require("tree-sitter-manager").setup(opts)
	-- end,
}
