local js = { "biome", "biome-check" }
local html = { "djlint", "rustywind" }
local makrdown = { "cbfmt", "markdownlint", "markdown-toc" }

return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_fallback = "fallback" })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	opts = {
		formatters_by_ft = {
			["_"] = { "trim_whitespace" },
			["*"] = { "injected" },
			asm = { "asmfmt" },
			bash = { "shfmt" },
			c = { "clang-format" },
			cmake = { "cmake_format" },
			cpp = { "clang-format" },
			css = { "prettier" },
			go = { "goimports", "gofmt" },
			html = html,
			htmldjango = html,
			http = { "kulala-fmt" },
			javascript = js,
			javascriptreact = js,
			json = { "jq" },
			lua = { "stylua" },
			markdown = makrdown,
			python = { "ruff_format", "ruff_fix", "ruff_organize_imports", "docformatter" },
			rest = { "kulala" },
			rust = { "rustfmt", "leptosfmt", "yew-fmt" },
			scss = { "prettier" },
			sql = { "sqruff" },
			toml = { "taplo" },
			typescript = js,
			typescriptreact = js,
			typst = { "typstyle" },
			vimwiki = makrdown,
			yaml = { "yamlfmt" },
		},
		formatters = {
			sqruff = {
				prepend_args = function(_self, _ctx)
					return {
						"--config",
						vim.fn.expand("~/.config/sqruff/config.cfg"),
					}
				end,
			},
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
		log_level = vim.log.levels.ERROR,
		notify_on_error = true,
	},
}
