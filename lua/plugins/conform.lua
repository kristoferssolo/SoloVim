local js = { "biome", "biome-check" }
return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
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
			css = { "prettier" },
			scss = { "prettier" },
			python = { "ruff", "ruff_fix", "ruff_organize_imports" },
			go = { "goimports", "gofmt" },
			javascript = js,
			javascriptreact = js,
			typescript = js,
			typescriptreact = js,
			markdown = { "cbfmt", "markdownlint", "markdown-toc" },
			vimwiki = { "cbfmt", "markdownlint", "markdown-toc" },
			json = { "jq" },
			c = { "clang-format" },
			toml = { "taplo" },
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
		format_on_save = function(bufnr)
			-- Disable formatting for .bru files
			local bufname = vim.api.nvim_buf_get_name(bufnr)
			if bufname:match("%.bru$") then
				return false
			end

			-- Return normal format settings for other files
			return {
				timeout_ms = 500,
				lsp_fallback = true,
			}
		end,
		log_level = vim.log.levels.ERROR,
		notify_on_error = true,
	},
}
