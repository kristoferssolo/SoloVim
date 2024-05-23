local js = { "biome", "biome-check", "rustywind" }
return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			-- Customize or remove this keymap to your liking
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "",
			desc = "[F]ormat buffer",
		},
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "auto_optional", "ruff", "ruff_fix", "ruff_organize_imports" },
			go = { "goimports", "gofmt" },
			-- toml = { "taplo" },
			javascript = js,
			javascriptreact = js,
			typescript = js,
			typescriptreact = js,
			markdown = { "cbfmt", "markdownlint" },
			vimwiki = { "cbfmt", "markdownlint" },
			c = { "clang-format" },
			cpp = { "clang-format" },
			cmake = { "cmake_format" },
			htmldjango = { "djlint", "rustywind" },
			html = { "djlint", "rustywind" },
			typst = { "typstyle" },
			rust = { "rustfmt", "leptosfmt", "yew-fmt" },
			sql = { "pg_format" },
			yaml = { "yamlfmt" },
			["_"] = { "trim_whitespace" },
		},
		format_on_save = {
			lsp_fallback = true,
			timeout_ms = 500,
		},
		log_level = vim.log.levels.ERROR,
		notify_on_error = true,
	},
}
