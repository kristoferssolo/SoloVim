return {
	"mrcjkb/rustaceanvim",
	version = "^4",
	enabled = false,
	-- TODO: configure rustaceanvim
	ft = { "rust" },
	--[[ keys = {
		{
			"",
			function()
				vim.cmd.RustLsp("codeAction")
			end,
			desc = "",
		},
	}, ]]
}
