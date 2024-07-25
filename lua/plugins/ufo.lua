return {
	"kevinhwang91/nvim-ufo",
	dependencies = { "kevinhwang91/promise-async" },
	event = "BufWinEnter",
	keys = {
		{
			"zR",
			function()
				require("ufo").openAllFolds()
			end,
			desc = "Open all folds",
		},
		{
			"zM",
			function()
				require("ufo").closeAllFolds()
			end,
			desc = "Close all folds",
		},
		{
			"zk",
			function()
				local winid = require("ufo").peekFoldedLinesUnderCursor()
				if not winid then
					vim.lsp.buf.hover()
				end
			end,
			desc = "Peek fold",
		},
	},
	opts = {
		open_fold_hl_timeout = 150,
		close_fold_kinds_for_ft = {
			default = { "imports", "comment" },
		},
		preview = {
			win_config = {
				winblend = 0,
			},
		},
		provider_selector = function(_, filetype, buftype)
			return { "lsp", "indent" }
		end,
	},
}
