return {
	"jay-babu/mason-null-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	enabled = false,
	dependencies = {
		"williamboman/mason.nvim",
		"nvim-lua/plenary.nvim",
		{ "nvimtools/none-ls.nvim", dependencies = {
			"nvimtools/none-ls-extras.nvim",
		} },
	},
	config = function()
		local null_ls = require("null-ls")
		-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
		local formatting = null_ls.builtins.formatting
		-- https://github.com/prettier-solidity/prettier-plugin-solidity
		local diagnostics = null_ls.builtins.diagnostics
		null_ls.setup({
			sources = {
				require("none-ls.diagnostics.cpplint"),
				-- Here you can add tools not supported by mason.nvim
				-- make sure the source name is supported by null-ls
				-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
				formatting.cbfmt.with({ extra_filetypes = { "vimwiki" } }),
				--[[ formatting.prettier.with({
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
				}), ]]
				formatting.sql_formatter.with({
					extra_args = {
						"-c",
						[[
						{
							"language": "postgresql",
							"dialect": "postgresql",
							"tabWidth": 2,
							"useTabs": false,
							"keywordCase": "upper",
							"dataTypeCase": "upper",
							"functionCase": "upper",
							"identifierCase": "upper",
							"indentStyle": "standard",
							"logicalOperatorNewline": "before",
							"expressionWidth": "80",
							"linesBetweenQueries": 2,
							"denseOperators": false,
							"newlineBeforeSemicolon": false
						}
						]],
					},
				}),
				formatting.rustywind.with({ extra_filetypes = { "htmldjango", "javascriptreact" } }),
			},
		})
		require("mason-null-ls").setup({
			ensure_installed = {
				"clang_format",
				"cmake_format",
				"cmake_lint",
				"google_java_format",
				"selene",
				"stylua",
				"yamlfmt",
				"rustywind",
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
