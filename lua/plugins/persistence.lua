return {
	"folke/persistence.nvim",
	event = "BufReadPre",
	keys = {
		{
			"<leader>qs",
			function()
				require("persistence").load()
			end,
			desc = "Restore the session for the current directory",
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
	opts = {
		dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"), -- directory where session files are saved
		options = { "buffers", "curdir", "tabpages", "winsize" }, -- sessionoptions used for saving
		pre_save = nil, -- a function to call before saving the session
		post_save = nil, -- a function to call after saving the session
		save_empty = false, -- don't save if there are no open file buffers
		pre_load = nil, -- a function to call before loading the session
		post_load = nil, -- a function to call after loading the session
	},
}
