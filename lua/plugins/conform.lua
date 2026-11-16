local js = { "oxfmt" }
local shell = { "shfmt" }

local function oxfmt_defaults(config_file)
	return function(self, ctx)
		if self.cwd and self.cwd(self, ctx) then
			return {}
		end
		return { "--config", vim.api.nvim_get_runtime_file("formatter-config/" .. config_file, false)[1] }
	end
end

local function skip_format(bufnr)
	local filename = vim.api.nvim_buf_get_name(bufnr)
	local basename = vim.fs.basename(filename)

	return basename == "package.json" or basename == "package-lock.json" or basename == "tsconfig.json"
end

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
			bash = shell,
			askama = { "djlint", "rustywind" },
			c = { "clang-format" },
			cmake = { "cmake_format" },
			cpp = { "clang-format" },
			css = { "oxfmt" },
			go = { "goimports", "gofmt" },
			html = { "oxfmt_html" },
			htmldjango = { "biome", "djlint", "rustywind" },
			http = { "kulala-fmt" },
			javascript = js,
			javascriptreact = js,
			jinja = { "djlint", "rustywind" },
			json = { "oxfmt" },
			json5 = { "oxfmt" },
			jsonc = { "oxfmt" },
			kdl = { "kdlfmt" },
			lua = { "stylua" },
			markdown = { "oxfmt", "markdownlint" },
			python = { "ruff_format", "ruff_fix", "ruff_organize_imports", "docformatter" },
			rest = { "kulala-fmt" },
			rust = { "rustfmt", "leptosfmt", "yew-fmt" },
			scss = { "oxfmt" },
			sh = shell,
			sql = { "sleek" },
			swift = { "swiftformat" },
			toml = { "oxfmt" },
			typescript = js,
			typescriptreact = js,
			typst = { "typstyle" },
			vimwiki = { "cbfmt", "markdownlint" },
			xml = { "xmlformatter" },
			yaml = { "oxfmt" },
			zsh = shell,
		},
		formatters = {
			oxfmt = {
				append_args = oxfmt_defaults("oxfmt.json"),
			},
			oxfmt_html = {
				inherit = "oxfmt",
				append_args = oxfmt_defaults("oxfmt-html.json"),
			},
			kdlfmt = {
				append_args = { "--kdl-version", "v1" },
			},
			injected = {
				condition = function(_, ctx)
					return not ctx.filename:match("%.jsonl$")
						and not ctx.filename:match("%.ndjson$")
						and not ctx.filename:match("%.jsonlines$")
				end,
			},
		},
		format_on_save = function(bufnr)
			if vim.g.skip_format_on_save or skip_format(bufnr) then
				return
			end
			return {
				timeout_ms = 500,
				lsp_format = "fallback",
			}
		end,
		log_level = vim.log.levels.DEBUG,
		notify_on_error = true,
	},
}
