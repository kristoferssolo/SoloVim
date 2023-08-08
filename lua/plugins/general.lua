return {
	{ "folke/lazy.nvim" },
	{ "nvim-lua/plenary.nvim" }, -- Useful lua functions used by lots of plugins
	{ "windwp/nvim-autopairs" }, -- Autopairs, integrates with both cmp and treesitter
	{ "numToStr/Comment.nvim" },
	{ "JoosepAlviste/nvim-ts-context-commentstring" },
	{ "nvim-tree/nvim-web-devicons", lazy = true },
	{ "nvim-tree/nvim-tree.lua" },
	{ "moll/vim-bbye" },

	{ "nvim-lualine/lualine.nvim" },
	{ "arkav/lualine-lsp-progress" },

	{ "akinsho/toggleterm.nvim" },
	{ "ahmedkhalf/project.nvim" },
	{ "lewis6991/impatient.nvim" },
	{ "lukas-reineke/indent-blankline.nvim" },

	{ "goolord/alpha-nvim", lazy = true },
	{ "willothy/veil.nvim", lazy = true },
	{ "henriquehbr/nvim-startup.lua", lazy = true },

	{ "andweeb/presence.nvim" },

	{ "NvChad/nvim-colorizer.lua" },
	{ "uga-rosa/ccc.nvim", lazy = true },

	{ "alvan/vim-closetag" },
	{ "tpope/vim-surround" },
	{ "mbbill/undotree", lazy = true },
	{ "preservim/tagbar" },
	{ "jghauser/mkdir.nvim", lazy = true },
	{ "mtdl9/vim-log-highlighting", lazy = true },
	{ "edluffy/hologram.nvim", lazy = true },

	{ "folke/which-key.nvim", lazy = true },
	{ "folke/todo-comments.nvim", lazy = false },
	{
		"folke/persistence.nvim",
		event = "BufReadPre", -- this will only start session saving when an actual file was opened
		module = "persistence",
	},
	{ "folke/zen-mode.nvim" },

	{ "christoomey/vim-tmux-navigator" },
	{ "ThePrimeagen/harpoon" },
	{ "ThePrimeagen/vim-be-good", lazy = true },

	-- Vimwiki
	{ "vimwiki/vimwiki" },
	{ "epwalsh/obsidian.nvim", lazy = true },

	{ "stevearc/oil.nvim" },

	-- Git
	{ "lewis6991/gitsigns.nvim" },

	{ "rest-nvim/rest.nvim", lazy = true },

	{ "chipsenkbeil/distant.nvim", lazy = true },
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},

	{
		"kevinhwang91/nvim-ufo",
		dependencies = {
			"kevinhwang91/promise-async",
		},
	},
}
