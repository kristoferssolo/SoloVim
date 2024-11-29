return {
	"danymat/neogen",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	version = "*",
	cmd = { "Neogen" },
	keys = {
		{
			"<leader>ss",
			function()
				require("neogen").generate()
			end,
			desc = "Generate docstings",
		},
	},
	opts = {
		enabled = true,
		input_after_comment = true, -- (default: true) automatic jump (with insert mode) on inserted annotation
		snippet_engine = "luasnip",
		languages = {
			python = {
				template = {
					annotation_convention = "google_docstrings", -- google_docstrings, numpydoc, reST
				},
			},
		},
	},
}
