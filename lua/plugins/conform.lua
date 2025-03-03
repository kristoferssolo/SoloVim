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
			desc = "[F]ormat buffer",
		},
	},
	opts = {
		formatters_by_ft = {
			bash = { "shfmt" },
			c = { "clang-format" },
			cmake = { "cmake_format" },
			cpp = { "clang-format" },
			css = { "prettier" },
			go = { "goimports", "gofmt" },
			html = { "djlint", "rustywind" },
			htmldjango = { "djlint", "rustywind" },
			javascript = js,
			javascriptreact = js,
			json = { "jq" },
			lua = { "stylua" },
			markdown = { "cbfmt", "markdownlint", "markdown-toc" },
			python = { "ruff_format", "ruff_fix", "ruff_organize_imports", "docformatter" },
			rust = { "rustfmt", "leptosfmt", "yew-fmt" },
			scss = { "prettier" },
			sql = { "pg_format" },
			toml = { "taplo" },
			typescript = js,
			typescriptreact = js,
			typst = { "typstyle" },
			vimwiki = { "cbfmt", "markdownlint", "markdown-toc" },
			yaml = { "yamlfmt" },
			["_"] = { "trim_whitespace" },
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
		log_level = vim.log.levels.ERROR,
		notify_on_error = true,
	},
}
