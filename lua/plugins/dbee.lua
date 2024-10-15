return {
	"kndndrj/nvim-dbee",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	keys = {
		{

			"<leader>od",
			function()
				require("dbee").toggle()
			end,
			desc = "Toggle Dbee",
		},
	},
	cmd = "Dbee",
	build = function()
		-- go install github.com/kndndrj/nvim-dbee/dbee@latest
		require("dbee").install("go")
	end,
	opts = {
		--- https://github.com/kndndrj/nvim-dbee/blob/master/lua/dbee/config.lua
	},
	config = function(_, opts)
		require("dbee").setup(opts)
	end,
}
