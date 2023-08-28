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
	{ "folke/lazy.nvim" },
	{ "nvim-lua/plenary.nvim" }, -- Useful lua functions used by lots of plugins
	{ "andweeb/presence.nvim" },
	{ "alvan/vim-closetag" },
	{ "mbbill/undotree" },
	{ "preservim/tagbar" },
	{ "jghauser/mkdir.nvim", lazy = true },
	{ "mtdl9/vim-log-highlighting", lazy = true },
	{ "christoomey/vim-tmux-navigator" },
	{ "ThePrimeagen/vim-be-good", lazy = true },
	{
		"chipsenkbeil/distant.nvim",
		branch = "v0.3",
		config = function()
			require("distant"):setup()
		end,
	},
	{
		"danymat/neogen",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = true,
		version = "*",
	},
	{ "eandrju/cellular-automaton.nvim", lazy = true },
	{ "laytan/cloak.nvim" },
	{ "NvChad/nvim-colorizer.lua" },
	{ "uga-rosa/ccc.nvim" },
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
	{ "bluz71/vim-nightfly-colors", name = "nightfly" },
	"numToStr/Comment.nvim",

	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" }, -- Required
			{ "williamboman/mason.nvim" }, -- Optional
			{ "williamboman/mason-lspconfig.nvim" }, -- Optional

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
			}, -- Required
			{ "hrsh7th/cmp-nvim-lsp" }, -- Required
			{
				"L3MON4D3/LuaSnip",
				build = "make install_jsregexp",
				dependencies = {
					"rafamadriz/friendly-snippets", -- a bunch of snippets to use
				},
			}, -- Required
			{ "saadparwaiz1/cmp_luasnip" },
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
				"alpha",
			},
		},
	},

	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"jose-elias-alvarez/null-ls.nvim",
		},
	},

	-- for formatters and linters
	{ "nanotee/sqls.nvim", lazy = true },
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
	"ThePrimeagen/harpoon",
	{ "p00f/clangd_extensions.nvim", ft = { "cpp", "c" } },
	{ "Civitasv/cmake-tools.nvim", ft = { "cpp", "c" }, dependencies = { "nvim-lua/plenary.nvim" } },
	{ "nvim-lualine/lualine.nvim" },
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
	{ "folke/todo-comments.nvim", opts = true },
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
	{ "RRethy/vim-illuminate" },
	{ "vimwiki/vimwiki" },
	{ "kdheepak/lazygit.nvim" },
	{ "tpope/vim-fugitive" },
	{ "lewis6991/gitsigns.nvim" },
	{ "ThePrimeagen/git-worktree.nvim" },
	{ "lukas-reineke/indent-blankline.nvim" },
	{ "ahmedkhalf/project.nvim" },
	{ "kdheepak/lazygit.nvim" },
	{
		"epwalsh/obsidian.nvim",
		lazy = true,
		event = {
			"BufReadPre " .. vim.fn.expand("~") .. "/vimwiki/**/*.md",
			"BufReadPre " .. vim.fn.expand("~") .. "/obsidian/**/*.md",
		},
	},
})
