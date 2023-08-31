return {
	-- core
	{ "folke/lazy.nvim" },
	{ "nvim-lua/plenary.nvim" }, -- Useful lua functions used by lots of plugins

	-- useful
	{ "ThePrimeagen/harpoon" },
	{ "preservim/tagbar" },
	{ "alvan/vim-closetag" },
	{ "mbbill/undotree" },
	{ "christoomey/vim-tmux-navigator" },
	{ "folke/todo-comments.nvim", opts = true },
	{ "ahmedkhalf/project.nvim" },
	{
		"chipsenkbeil/distant.nvim",
		branch = "v0.3",
		config = function()
			require("distant"):setup()
		end,
	},
	{ "laytan/cloak.nvim" },
	{ "numToStr/Comment.nvim" },
	{ "folke/which-key.nvim", lazy = true },

	-- lsp
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{
				"williamboman/mason.nvim",
				opts = {
					ui = {
						border = "single",
					},
				},
			},
			{
				"williamboman/mason-lspconfig.nvim",
				opts = {
					automatic_installation = true,
					automatic_setup = true,
				},
			},

			-- Autocompletion
			{
				"hrsh7th/nvim-cmp",
				event = "InsertEnter",
				dependencies = {
					"hrsh7th/cmp-buffer", -- buffer completions
					"hrsh7th/cmp-path", -- path completionsplu
					"hrsh7th/cmp-nvim-lua",
					"hrsh7th/cmp-nvim-lsp",
				},
			},
			{ "hrsh7th/cmp-nvim-lsp" },
			{
				"L3MON4D3/LuaSnip",
				build = "make install_jsregexp",
				dependencies = {
					"rafamadriz/friendly-snippets", -- a bunch of snippets to use
				},
			},
			{ "saadparwaiz1/cmp_luasnip" },
		},
	},
	{
		"folke/neodev.nvim",
		opts = {
			library = { plugins = { "nvim-dap-ui" }, types = true },
		},
		dependencies = {
			"rcarriga/nvim-dap-ui",
		},
	},
	{ "nanotee/sqls.nvim", lazy = true },
	{ "p00f/clangd_extensions.nvim", ft = { "cpp", "c" } },
	{ "Civitasv/cmake-tools.nvim", ft = { "cpp", "c", "cmake" }, dependencies = { "nvim-lua/plenary.nvim" } },
	{
		"simrat39/rust-tools.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
		},
		ft = "rust",
	},
	{
		"Saecki/crates.nvim",
		ft = { "rust", "toml" },
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{
		"windwp/nvim-autopairs", -- Autopairs, integrates with both cmp and treesitter
		event = "InsertEnter",
		opts = {
			check_ts = true, -- treesitter integration
			disable_filetype = {
				"NvimTree",
				"TelescopePrompt",
			},
		},
	},

	-- formatters and linters
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"jose-elias-alvarez/null-ls.nvim",
		},
	},

	-- debuggers
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
	},
	{ "theHamsta/nvim-dap-virtual-text" },
	{
		"jayp0521/mason-nvim-dap.nvim",
		opts = {
			ensure_installed = {
				"debugpy",
				"codelldb",
			},
		},
		dependencies = {
			"williamboman/mason.nvim",
		},
	},
	{
		"mfussenegger/nvim-dap-python",
		ft = "python",
		dependencies = {
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui",
		},
	},

	-- treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/playground",
			"p00f/nvim-ts-rainbow",
			"mechatroner/rainbow_csv",
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
	},

	-- telescope
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			{ "nvim-telescope/telescope-media-files.nvim" },
			{ "xiyaowong/telescope-emoji.nvim" },
			{ "nvim-telescope/telescope-frecency.nvim" },
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			{ "nat-418/telescope-color-names.nvim" },
			{ "nvim-telescope/telescope-dap.nvim", dependencies = {
				"nvim-dap",
			} },
		},
	},

	-- pretty
	{ "uga-rosa/ccc.nvim" },
	{ "lukas-reineke/indent-blankline.nvim" },
	{ "NvChad/nvim-colorizer.lua" },
	{ "mtdl9/vim-log-highlighting", lazy = true },
	{ "RRethy/vim-illuminate" },
	{
		"danymat/neogen",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = true,
		version = "*",
	},
	{ "nvim-lualine/lualine.nvim" },
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

	-- git
	{ "kdheepak/lazygit.nvim" },
	{ "tpope/vim-fugitive" },
	{ "lewis6991/gitsigns.nvim" },
	{ "ThePrimeagen/git-worktree.nvim" },
	{ "sindrets/diffview.nvim" },

	-- text
	{ "vimwiki/vimwiki" },
	{
		"epwalsh/obsidian.nvim",
		lazy = true,
		event = {
			"BufReadPre " .. vim.fn.expand("~") .. "/vimwiki/**/*.md",
			"BufReadPre " .. vim.fn.expand("~") .. "/obsidian/**/*.md",
		},
	},
	{ "lervag/vimtex" },
	{
		"iamcco/markdown-preview.nvim",
		ft = { "markdown", "vimwiki" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown", "vimwiki" }
		end,
	},

	-- fun
	{ "andweeb/presence.nvim" },
	{ "ThePrimeagen/vim-be-good", lazy = true },
	{ "eandrju/cellular-automaton.nvim" },
}
