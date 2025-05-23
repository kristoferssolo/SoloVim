return {
	"lervag/vimtex",
	enabled = false,
	ft = "tex",
	keys = {
		{ "<leader>Tb", vim.cmd.VimtexCompile, desc = "Build", ft = "tex" },
		{ "<leader>Tv", vim.cmd.VimtexView, desc = "View", ft = "tex" },
		{ "<leader>Tw", vim.cmd.VimtexCountWords, desc = "Word Count", ft = "tex" },
		{ "<leader>Tt", vim.cmd.VimtexTocToggle, desc = "Table of Contents", ft = "tex" },
		{ "<leader>Tc", vim.cmd.VimtexClean, desc = "Clean aux", ft = "tex" },
		{ "<leader>Te", vim.cmd.VimtexErrors, desc = "Report Errors", ft = "tex" },
		{ "<leader>Ti", vim.cmd.VimtexInfo, desc = "Info", ft = "tex" },
	},
}
