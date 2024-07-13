return {
	"emmanueltouzery/decisive.nvim",
	keys = {
		{
			"<leader>cCa",
			function()
				require("decisive").align_csv({})
			end,
			desc = "align CSV",
		},
		{
			"<leader>cCA",
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
