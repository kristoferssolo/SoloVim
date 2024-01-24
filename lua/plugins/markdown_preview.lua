return {
	"iamcco/markdown-preview.nvim",
	ft = { "markdown", "vimwiki" },
	build = "cd app && yarn install",
	init = function()
		vim.g.mkdp_filetypes = { "markdown", "vimwiki" }
	end,
}
