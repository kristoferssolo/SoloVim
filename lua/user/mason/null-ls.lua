local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

local mason_null_ls_status_ok, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

-- https://github.com/prettier-solidity/prettier-plugin-solidity
null_ls.setup({
	debug = false,
	sources = {
		formatting.autopep8,
		formatting.beautysh,
		formatting.djlint,
		formatting.prettier.with({
			extra_filetypes = { "toml" },
			extra_args = {
				"--no-semi",
				"--double-quote",
				"--no-bracket-spacing",
				"--tab-width",
				"4",
				"--bracket-same-line",
				"--html-whitespace-sensitivity",
				"strict",
			},
		}),
		formatting.shfmt,
		formatting.stylua,
		formatting.isort,
		formatting.yamlfmt,
		diagnostics.cpplint,
		diagnostics.luacheck,
		diagnostics.flake8,
		diagnostics.mypy,
		diagnostics.zsh,
		diagnostics.misspell,
		diagnostics.codespell,
	},
})

mason_null_ls.setup({
	ensure_installed = {
		"autopep8",
		"beautysh",
		"codespell",
		"cpplint",
		"djlint",
		"flake8",
		"gitlint",
		"html_lint",
		"luacheck",
		"misspell",
		"mypy",
		"shfmt",
		"yamlfmt",
	},
	automatic_installation = true,
	automatic_setup = true,
})
