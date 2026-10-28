return {
	"romus204/tree-sitter-manager.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
	},
	opts = {
		ensure_installed = {
			"askama",
			"cpp",
			"git_config",
			"git_rebase",
			"gitattributes",
			"gitcommit",
			"gitignore",
			"http",
			"html",
			"jinja",
			"jinja_inline",
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
		languages = {
			askama = {
				install_info = {
					url = "https://github.com/qvalentin/tree-sitter-askama",
					branch = "main",
					queries = "queries",
				},
			},
			jsonl = {
				install_info = {
					url = "https://github.com/kristoferssolo/tree-sitter-jsonl",
					branch = "main",
				},
			},
		},
	},
}
