vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_context_pdf_viewer = "zathura"
vim.g.vimtex_quickfix_mode = 0
vim.g.vimtex_mappings_enabled = 0
vim.g.vimtex_indent_enabled = 1
vim.g.vimtex_log_ignore = {
	"Underfull",
	"Overfull",
	"specifier changed to",
	"Token not allowed in a PDF string",
}
vim.g.vimtex_compiler_latexmk_engines = {
	["_"] = "-xelatex",
}
vim.g.vimtex_compiler_latexmk = {
	aux_dir = "target",
	out_dir = "target/build",
	callback = 1,
	continuous = 1,
	executable = "latexmk",
	hooks = {},
	options = {
		"-verbose",
		"-file-line-error",
		"-synctex=1",
		"-interaction=nonstopmode",
		"-shell-escape",
	},
}
vim.g.vimtex_complete_enabled = 1
vim.g.vimtex_complete_close_braces = 1
