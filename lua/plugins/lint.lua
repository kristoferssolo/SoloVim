local js = { "biomejs" }
return {
	"mfussenegger/nvim-lint",
	opts = {
		events = { "InsertLeave", "BufWritePost", "BufReadPost", "InsertEnter" },
		linters_by_ft = {
			javascript = js,
			javascriptreact = js,
			typescript = js,
			typescriptreact = js,
			python = { "mypy" },
			htmldjango = { "djlint" },
			sql = { "sqruff" },
			lua = { "selene" },
			cmake = { "cmakelint" },
			["*"] = { "codespell", "typos" },
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
