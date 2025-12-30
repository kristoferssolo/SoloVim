return {
	"XXiaoA/atone.nvim",
	cmd = "Atone",
	keys = {
		{
			"<leader>u",
			function()
				vim.cmd("Atone toggle")
			end,
			desc = "Toggle Undotree",
		},
	},
	opts = {
		ui = {
			compact = true,
		},
	},
}
