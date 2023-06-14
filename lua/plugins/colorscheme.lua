return {
	{ "lunarvim/darkplus.nvim" },
	{
		"catppuccin/nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "frappe",
				transparent_background = true,
				term_colors = true,
			})
			-- vim.cmd.colorscheme("catppuccin")
		end,
	},
	{
		"Mofiqul/dracula.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("dracula").setup({
				transparent_bg = true,
				italic_comment = true,
			})
			-- vim.cmd.colorscheme("dracula")
		end,
	},
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
	{ "rebelot/kanagawa.nvim" },
	{ "EdenEast/nightfox.nvim" },
	{ "navarasu/onedark.nvim" },
	{ "savq/melange-nvim" },
	{ "bluz71/vim-nightfly-colors", name = "nightfly" },
}
