return {
	"kaarmu/typst.vim",
	ft = "typst",
	keys = {
		{
			"<leader>ow",
			vim.cmd.TypstWatch,
			desc = "Typst watch",
		},
	},
	config = function()
		-- vim.g.typst_cmd = "typst" -- Specifies the location of the Typst executable. Default: 'typst'
		-- vim.g.typst_pdf_viewer = "zathura" -- Specifies pdf viewer that typst watch --open will use. Default: ''
		-- vim.g.typst_conceal = 0 -- Enable concealment. Default: 0
		-- vim.g.typst_conceal_math = vim.g.typst_conceal -- Enable concealment for math symbols in math mode (i.e. replaces symbols with their actual unicode character). Default: g:typst_conceal
		-- vim.g.typst_conceal_emoji = vim.g.typst_conceal -- Enable concealing emojis, e.g. #emoji.alien becomes 👽. Default: g:typst_conceal
		-- vim.g.typst_auto_close_toc = 0 -- Specifies whether TOC will be automatically closed after using it. Default: 0
		-- vim.g.typst_auto_open_quickfix = 1 -- Specifies whether the quickfix list should automatically open when there are errors from typst. Default: 1
		-- vim.g.typst_embedded_languages = { "python", "rust", "c", "cpp" } -- A list of languages that will be highlighted in code blocks. Typst is always highlighted. Default: []
	end,
}
