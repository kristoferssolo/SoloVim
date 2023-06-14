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
	{ "akinsho/toggleterm.nvim" },
	{ "ahmedkhalf/project.nvim" },
	{ "lewis6991/impatient.nvim" },
	{ "lukas-reineke/indent-blankline.nvim" },
	{ "goolord/alpha-nvim", lazy = true },
	{ "andweeb/presence.nvim" },
	{ "NvChad/nvim-colorizer.lua" },
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

	{ "stevearc/oil.nvim" },

	-- C++
	{ "p00f/clangd_extensions.nvim", lazy = true },
	{ "Civitasv/cmake-tools.nvim", lazy = true },

	-- Rust
	{ "Saecki/crates.nvim", lazy = true },
	{ "simrat39/rust-tools.nvim", lazy = true },

	-- Git
	{ "lewis6991/gitsigns.nvim" },

	{ "codota/tabnine-nvim", build = "./dl_binaries.sh" },
}
