return {
	"kndndrj/nvim-dbee",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	cmd = "Dbee",
	build = function()
		-- Install tries to automatically detect the install method.
		-- if it fails, try calling it with one of these parameters:
		--    "curl", "wget", "bitsadmin", "go"
		require("dbee").install("curl")
	end,
	opts = {
		--- https://github.com/kndndrj/nvim-dbee/blob/master/lua/dbee/config.lua
	},
	config = function(_, opts)
		require("dbee").setup(opts)
	end,
}
