local js = { "biome", "biome-check" }
local html = { "djlint", "rustywind" }
local markdown = { "cbfmt", "markdownlint", "markdown-toc" }
local shell = { "shfmt" }

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
			mode = { "n", "v", "x" },
			desc = "Format buffer",
		},
	},
	opts = {
		formatters_by_ft = {
			["_"] = { "trim_whitespace" },
			["*"] = { "injected" },
			asm = { "asmfmt" },
			bash = shell,
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
			kdl = { "kdlfmt" },
			lua = { "stylua" },
			markdown = markdown,
			python = { "ruff_format", "ruff_fix", "ruff_organize_imports", "docformatter" },
			rest = { "kulala" },
			rust = { "rustfmt", "leptosfmt", "yew-fmt" },
			scss = { "prettier" },
			sh = shell,
			sql = { "sqruff" },
			toml = { "taplo" },
			typescript = js,
			typescriptreact = js,
			typst = { "typstyle" },
			vimwiki = markdown,
			yaml = { "yamlfmt" },
			zsh = shell,
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
			injected = {
				condition = function(_, ctx)
					return not ctx.filename:match("%.jsonl$")
						and not ctx.filename:match("%.ndjson$")
						and not ctx.filename:match("%.jsonlines$")
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
