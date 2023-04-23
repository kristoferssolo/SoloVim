local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

local mason_null_ls_status_ok, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status_ok then
	return
end

mason_null_ls.setup({
	ensure_installed = {
		"autopep8",
		"beautysh",
		"clang_format",
		"codespell",
		"cpplint",
		"djlint",
		"gitlint",
		"html_lint",
		"isort",
		"luacheck",
		"misspell",
		"mypy",
		"phpcbf",
		"phpcs",
		"prettier",
		"rustfmt",
		"sql-formatter",
		"shfmt",
		"yamlfmt",
	},
	automatic_installation = true,
	automatic_setup = true,
})

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
-- https://github.com/prettier-solidity/prettier-plugin-solidity
null_ls.setup({
	debug = false,
	sources = {
		diagnostics.codespell,
		diagnostics.cpplint,
		diagnostics.luacheck.with({
			extra_args = {
				"--globals",
				"vim",
			},
		}),
		diagnostics.misspell,
		diagnostics.mypy,
		formatting.autopep8,
		formatting.beautysh,
		formatting.clang_format,
		formatting.djlint,
		formatting.google_java_format,
		formatting.isort,
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
		formatting.phpcbf,
		formatting.rustfmt,
		formatting.shfmt.with({
			extra_filetypes = {
				"bash",
				"csh",
				"ksh",
				"sh",
				"zsh",
			},
		}),
		formatting.sql_formatter,
		formatting.stylua,
		formatting.yamlfmt,
	},
})
