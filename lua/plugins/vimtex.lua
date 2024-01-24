return {
	"lervag/vimtex",
	keys = {
		{ "<leader>Tb", vim.cmd.VimtexCompile, desc = "[B]uild" },
		{ "<leader>Tv", vim.cmd.VimtexView, desc = "[V]iew" },
		{ "<leader>Tw", vim.cmd.VimtexCountWords, desc = "[W]ord Count" },
		{ "<leader>Tt", vim.cmd.VimtexTocToggle, desc = "[T]able of Contents" },
		{ "<leader>Tc", vim.cmd.VimtexClean, desc = "[C]lean aux" },
		{ "<leader>Te", vim.cmd.VimtexErrors, desc = "Report [E]rrors" },
		{ "<leader>Ti", vim.cmd.VimtexInfo, desc = "[I]nfo" },
	},
}
