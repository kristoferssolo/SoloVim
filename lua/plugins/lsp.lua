return {
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig", -- enable LSP
	{ "jose-elias-alvarez/null-ls.nvim", event = "VeryLazy" }, -- for formatters and linters
	"jayp0521/mason-null-ls.nvim",
	"RRethy/vim-illuminate",
	{ "nanotee/sqls.nvim", lazy = true },

	-- C++
	{ "p00f/clangd_extensions.nvim", lazy = true },
	{ "Civitasv/cmake-tools.nvim", lazy = true },

	-- Rust
	{ "Saecki/crates.nvim", lazy = true },
	{ "simrat39/rust-tools.nvim", lazy = true },

	-- { "codota/tabnine-nvim", event = "VeryLazy", build = "./dl_binaries.sh" },
}
