return {
	"emmanueltouzery/decisive.nvim",
	keys = {
		{
			"<leader>cca",
			function()
				require("decisive").align_csv({})
			end,
			desc = "align CSV",
		},
		{
			"<leader>ccA",
			function()
				require("decisive").align_csv_clear({})
			end,
			desc = "align CSV clear",
		},
		{
			"[c",
			function()
				require("decisive").align_csv_prev_col()
			end,
			desc = "align CSV prev col",
		},
		{
			"]c",
			function()
				require("decisive").align_csv_next_col()
			end,
			desc = "align CSV next col",
		},
	},
	opts = {},
}
