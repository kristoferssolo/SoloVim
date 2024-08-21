return {
	{
		"folke/tokyonight.nvim",
		--[[ lazy = false,
		priority = 1000,
		opts = {
			style = "night",
			transparent = true,
			styles = {
				keywords = { italic = false },
				sidebars = "transparent",
				floats = "transparent",
			},
			lualine_bold = true,
		},
		config = function(_, opts)
			require("tokyonight").setup(opts)
			vim.cmd.colorscheme("tokyonight")
		end, ]]
	},
	{ "lunarvim/darkplus.nvim" },
	{ "catppuccin/nvim", name = "catppuccin.nvim" },
	{ "Mofiqul/dracula.nvim" },
	{ "rebelot/kanagawa.nvim" },
	{ "EdenEast/nightfox.nvim" },
	{ "navarasu/onedark.nvim" },
	{ "savq/melange-nvim", name = "melange.nvim" },
	{ "ellisonleao/gruvbox.nvim" },
	{ "bluz71/vim-nightfly-colors", name = "nightfly.nvim" },
	{ "0xstepit/flow.nvim" },
	{ "Aliqyan-21/darkvoid.nvim" },
	{
		"rose-pine/neovim",
		name = "rose-pine.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			styles = {
				bold = true,
				italic = false,
				transparency = true,
			},
		},
		config = function(_, opts)
			require("rose-pine").setup(opts)
			vim.cmd.colorscheme("rose-pine")
		end,
	},
	{ "slugbyte/lackluster.nvim" },
}
