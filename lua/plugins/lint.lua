local js = { "biomejs" }
return {
	"mfussenegger/nvim-lint",
	opts = {
		events = { "InsertLeave", "BufWritePost", "BufReadPost", "InsertEnter" },
		linters_by_ft = {
			["*"] = { "codespell", "typos" },
			cmake = { "cmakelint" },
			haskell = { "hlint" },
			htmldjango = { "djlint" },
			javascript = js,
			javascriptreact = js,
			lua = { "selene" },
			python = { "mypy" },
			sql = { "sqruff" },
			typescript = js,
			typescriptreact = js,
		},
	},
	config = function(_, opts)
		local lint = require("lint")
		lint.linters_by_ft = opts.linters_by_ft
		vim.api.nvim_create_autocmd(opts.events, {
			group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}
