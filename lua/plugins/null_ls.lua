return {
	"jay-babu/mason-null-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
		"nvim-lua/plenary.nvim",
		"nvimtools/none-ls.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
		local formatting = null_ls.builtins.formatting
		-- https://github.com/prettier-solidity/prettier-plugin-solidity
		local diagnostics = null_ls.builtins.diagnostics
		null_ls.setup({
			sources = {
				-- Here you can add tools not supported by mason.nvim
				-- make sure the source name is supported by null-ls
				-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
				formatting.ruff.with({ extra_args = { "format" } }),
				diagnostics.luacheck.with({ extra_args = { "--globals", "vim" } }),
				formatting.cbfmt.with({ extra_filetypes = { "vimwiki" } }),
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
				-- formatting.markdownlint.with({ extra_filetypes = { "vimwiki" }, }),
				formatting.markdown_toc.with({ extra_filetypes = { "vimwiki" } }),
				-- formatting.shellharden.with({ extra_filetypes = { "bash", "csh", "ksh", "zsh" } }),
				-- formatting.shfmt.with({ extra_filetypes = { "bash", "csh", "ksh", "zsh" } }),
				-- formatting.sqlfluff.with({ extra_args = { "--dialect", "postgres" } }),
			},
		})
		require("mason-null-ls").setup({
			ensure_installed = {
				"cbfmt",
				"clang_format",
				"cmake_format",
				"cmake_lint",
				"cpplint",
				"djlint",
				"google_java_format",
				"luacheck",
				"markdown_toc",
				"mypy",
				"stylua",
				"yamlfmt",
				"rustywind",
				"ruff",
				"letexindent",
			},
			automatic_installation = true,
			handlers = {
				-- Here you can add functions to register sources.
				-- See https://github.com/jay-babu/mason-null-ls.nvim#handlers-usage
				--
				-- If left empty, mason-null-ls will use a "default handler"
				-- to register all sources
			},
		})
	end,
}
