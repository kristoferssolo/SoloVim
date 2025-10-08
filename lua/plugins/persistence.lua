return {
	"folke/persistence.nvim",
	event = "BufReadPre",
	keys = {
		{
			"<leader>qq",
			function()
				require("persistence").load()
			end,
			desc = "Restore the session for the current directory",
		},
		{
			"<leader>qs",
			function()
				require("persistence").select()
			end,
			desc = "Select a session to load",
		},
		{
			"<leader>ql",
			function()
				require("persistence").load({ last = true })
			end,
			desc = "Restore the last session",
		},
		{
			"<leader>qd",
			function()
				require("persistence").stop()
			end,
			desc = "Stop Persistence => session won't be saved on exit",
		},
	},
	opts = {},
}
