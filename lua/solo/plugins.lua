local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
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
	"numToStr/Comment.nvim",

	-- lsp
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },

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
	{ "nanotee/sqls.nvim", lazy = true },
	{ "p00f/clangd_extensions.nvim", ft = { "cpp", "c" } },
	{ "Civitasv/cmake-tools.nvim", ft = { "cpp", "c" }, dependencies = { "nvim-lua/plenary.nvim" } },
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
		dependencies = { "jayp0521/mason-nvim-dap.nvim" },
	},
	{
		"jayp0521/mason-nvim-dap.nvim",
		dependencies = {
			{
				"williamboman/mason.nvim",
				opts = {
					automatic_installation = true,
					automatic_setup = true,
				},
			},
			"mfussenegger/nvim-dap",
		},
	},
	{ "ravenxrz/DAPInstall.nvim", lazy = true },

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

	-- fun
	{ "andweeb/presence.nvim" },
	{ "ThePrimeagen/vim-be-good", lazy = true },
	{ "eandrju/cellular-automaton.nvim" },
})
