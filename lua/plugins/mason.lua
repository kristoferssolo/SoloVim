return {
	"mason-org/mason-lspconfig.nvim",
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"neovim/nvim-lspconfig",
		{
			"Senal-D-A-Gunaratna/swapson.nvim",
			opts = {
				npm = {
					enabled = true, -- set false to skip npm->bun patching
					tool = "bun", -- the bun binary name/path

					-- Whether to also patch mason's npm version-lookup client
					-- (npm view --json) — needed on systems with NO npm installed at all,
					-- since version lookups would otherwise still shell out to npm
					patch_version_lookup = true,
				},
				pip = {
					enabled = true, -- set false to skip pip->uv patching
					tool = "uv", -- the uv binary name/path
				},
			},
		},
	},
	opts = {
		ensure_installed = {
			-- "basedpyright",
			"bashls",
			"css_variables",
			"cssls",
			"html",
			"hyprls",
			"jsonls",
			"lua_ls",
			"markdown_oxide",
			"ruff",
			"tinymist",
			-- "ty",
			"zuban",
		},
	},
}
