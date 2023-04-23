local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	group = vim.api.nvim_create_augroup("AutoPackerSync", { clear = true }),
	pattern = { "**/plugins.lua" },
	callback = function()
		vim.cmd.PackerSync()
	end,
})

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	use("wbthomason/packer.nvim") -- Have packer manage itself
	use("nvim-lua/plenary.nvim") -- Useful lua functions used by lots of plugins
	use("windwp/nvim-autopairs") -- Autopairs, integrates with both cmp and treesitter
	use("numToStr/Comment.nvim")
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use("nvim-tree/nvim-web-devicons")
	use("nvim-tree/nvim-tree.lua")
	use({ "akinsho/bufferline.nvim", tag = "v3.*" })
	use("moll/vim-bbye")
	use("nvim-lualine/lualine.nvim")
	use("akinsho/toggleterm.nvim")
	use("ahmedkhalf/project.nvim")
	use("lewis6991/impatient.nvim")
	use("lukas-reineke/indent-blankline.nvim")
	use("goolord/alpha-nvim")
	use("andweeb/presence.nvim")
	use("NvChad/nvim-colorizer.lua")
	use("alvan/vim-closetag")
	use("tpope/vim-surround")

	use("folke/which-key.nvim")
	use("folke/todo-comments.nvim")
	use({
		"folke/persistence.nvim",
		event = "BufReadPre", -- this will only start session saving when an actual file was opened
		module = "persistence",
	})

	-- Colorschemes
	use("lunarvim/darkplus.nvim")
	use("Mofiqul/dracula.nvim")
	use("folke/tokyonight.nvim")
	use("rebelot/kanagawa.nvim")
	use("EdenEast/nightfox.nvim")
	use("navarasu/onedark.nvim")
	use("savq/melange-nvim")
	use({ "bluz71/vim-nightfly-colors", as = "nightfly" })

	-- Vimwiki
	use("vimwiki/vimwiki")

	-- cmp plugins
	use("hrsh7th/nvim-cmp") -- The completion pluginpluguse "nvim-lua/plenary.nvim"
	use("hrsh7th/cmp-buffer") -- buffer completions
	use("hrsh7th/cmp-path") -- path completionsplu
	use("hrsh7th/cmp-nvim-lua")
	use("hrsh7th/cmp-nvim-lsp")
	use("saadparwaiz1/cmp_luasnip") -- snippet completions

	-- snippets
	use({ "L3MON4D3/LuaSnip", run = "make install_jsregexp" }) --snippet engine
	use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

	-- LSP
	-- use("williamboman/nvim-lsp-installer") -- simple to use language server installer
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")
	use("neovim/nvim-lspconfig") -- enable LSP
	use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters
	use("jayp0521/mason-null-ls.nvim")
	use("RRethy/vim-illuminate")

	-- C++
	use("p00f/clangd_extensions.nvim")

	-- Rust
	use("Saecki/crates.nvim")
	use("simrat39/rust-tools.nvim")

	-- Telescope
	use({ "nvim-telescope/telescope.nvim", run = ":TSUpdate" })
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use("nvim-telescope/telescope-media-files.nvim")
	use("xiyaowong/telescope-emoji.nvim")
	use("nvim-telescope/telescope-frecency.nvim")

	-- Treesitter
	use("nvim-treesitter/nvim-treesitter")
	use("p00f/nvim-ts-rainbow")
	use("mechatroner/rainbow_csv")
	use("mtdl9/vim-log-highlighting")

	-- Git
	use("lewis6991/gitsigns.nvim")

	-- DAP
	use("mfussenegger/nvim-dap")
	use("rcarriga/nvim-dap-ui")
	use("jayp0521/mason-nvim-dap.nvim")
	use("ravenxrz/DAPInstall.nvim")

	use("ThePrimeagen/vim-be-good")

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
