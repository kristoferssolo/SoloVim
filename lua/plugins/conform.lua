local js = { "biome", "biome-check" }
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
			bash = { "shfmt" },
			c = { "clang-format" },
			cmake = { "cmake_format" },
			cpp = { "clang-format" },
			css = { "prettier" },
			go = { "goimports", "gofmt" },
			html = { "djlint", "rustywind" },
			htmldjango = { "djlint", "rustywind" },
			http = { "kulala-fmt" },
			javascript = js,
			javascriptreact = js,
			json = { "jq" },
			lua = { "stylua" },
			markdown = { "cbfmt", "markdownlint", "markdown-toc" },
			python = { "ruff_format", "ruff_fix", "ruff_organize_imports", "docformatter" },
			rest = { "kulala" },
			rust = { "rustfmt", "leptosfmt", "yew-fmt" },
			scss = { "prettier" },
			sql = { "sqruff" },
			toml = { "taplo" },
			typescript = js,
			typescriptreact = js,
			typst = { "typstyle" },
			vimwiki = { "cbfmt", "markdownlint", "markdown-toc" },
			yaml = { "yamlfmt" },
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
		log_level = vim.log.levels.ERROR,
		notify_on_error = true,
	},
}
