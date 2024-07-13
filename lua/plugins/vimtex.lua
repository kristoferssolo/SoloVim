return {
	"lervag/vimtex",
	ft = "tex",
	keys = {
		{ "<leader>Tb", vim.cmd.VimtexCompile, desc = "[B]uild", ft = "tex" },
		{ "<leader>Tv", vim.cmd.VimtexView, desc = "[V]iew", ft = "tex" },
		{ "<leader>Tw", vim.cmd.VimtexCountWords, desc = "[W]ord Count", ft = "tex" },
		{ "<leader>Tt", vim.cmd.VimtexTocToggle, desc = "[T]able of Contents", ft = "tex" },
		{ "<leader>Tc", vim.cmd.VimtexClean, desc = "[C]lean aux", ft = "tex" },
		{ "<leader>Te", vim.cmd.VimtexErrors, desc = "Report [E]rrors", ft = "tex" },
		{ "<leader>Ti", vim.cmd.VimtexInfo, desc = "[I]nfo", ft = "tex" },
	},
}
