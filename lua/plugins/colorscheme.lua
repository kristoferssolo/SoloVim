return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("tokyonight").setup({
				style = "night",
				transparent = true,
				styles = {
					keywords = { italic = false },
					sidebars = "transparent",
					floats = "transparent",
				},
				lualine_bold = true,
			})
			vim.cmd.colorscheme("tokyonight")
		end,
	},
	{ "lunarvim/darkplus.nvim" },
	{ "catppuccin/nvim" },
	{ "Mofiqul/dracula.nvim" },
	{ "rebelot/kanagawa.nvim" },
	{ "EdenEast/nightfox.nvim" },
	{ "navarasu/onedark.nvim" },
	{ "savq/melange-nvim" },
	{ "bluz71/vim-nightfly-colors", name = "nightfly" },
}
