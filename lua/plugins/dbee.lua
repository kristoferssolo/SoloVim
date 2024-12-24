return {
	"kndndrj/nvim-dbee",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	keys = {
		{
			"<leader>od",
			require("dbee").toggle,
			desc = "Toggle Dbee",
		},
	},
	cmd = { "Dbee" },
	build = function()
		require("dbee").install("go")
	end,
	opts = {
		--- https://github.com/kndndrj/nvim-dbee/blob/master/lua/dbee/config.lua
	},
	config = function(_, opts)
		require("dbee").setup(opts)
	end,
}
