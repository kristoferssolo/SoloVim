local status_ok, indent_blankline = pcall(require, "indent_blankline")
if not status_ok then
	return
end

local g = vim.g
local opt = vim.opt
local cmd = vim.cmd
g.indent_blankline_buftype_exclude = { "terminal", "nofile" }
g.indent_blankline_filetype_exclude = {
	"help",
	"startify",
	"dashboard",
	"packer",
	"neogitstatus",
	"NvimTree",
	"Trouble",
}
g.indentLine_enabled = 1
g.indent_blankline_char = "▎"
g.indent_blankline_show_trailing_blankline_indent = false
g.indent_blankline_show_first_indent_level = true
g.indent_blankline_use_treesitter = true
g.indent_blankline_show_current_context = true
g.indent_blankline_context_patterns = {
	"class",
	"return",
	"function",
	"method",
	"^if",
	"^while",
	"jsx_element",
	"^for",
	"^object",
	"^table",
	"block",
	"arguments",
	"if_statement",
	"else_clause",
	"jsx_element",
	"jsx_self_closing_element",
	"try_statement",
	"catch_clause",
	"import_statement",
	"operation_type",
}
vim.wo.colorcolumn = "99999"
cmd([[highlight IndentBlanklineIndent1 guifg=#C678DD gui=nocombine]])
cmd([[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]])
cmd([[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]])
cmd([[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]])
cmd([[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]])
cmd([[highlight IndentBlanklineIndent6 guifg=#E06C75 gui=nocombine]])
opt.list = true
opt.listchars:append("space:⋅")
opt.listchars:append("eol:↴")
indent_blankline.setup({
	char = "▏",
	show_trailing_blankline_indent = false,
	show_first_indent_level = true,
	use_treesitter = true,
	show_end_of_line = true,
	space_char_blankline = " ",
	show_current_context = true,
	show_current_context_start = true,
	char_highlight_list = {
		"IndentBlanklineIndent1",
		"IndentBlanklineIndent2",
		"IndentBlanklineIndent3",
		"IndentBlanklineIndent4",
		"IndentBlanklineIndent5",
		"IndentBlanklineIndent6",
	},
	buftype_exclude = { "terminal", "nofile" },
	filetype_exclude = {
		"help",
		"packer",
		"NvimTree",
	},
})
