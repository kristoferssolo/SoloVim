return {
	"oysandvik94/curl.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	keys = {
		{
			"<leader>co",
			vim.cmd.CurlOpen,
			desc = "[C]url [O]pen",
		},
		{
			"<leader>cc",
			vim.cmd.CurlClose,
			desc = "[C]url [C]lose",
		},
	},
	cmd = { "CurlOpen", "CurlClose" },
	opts = {
		default_flags = {},
		mappings = {
			execute_curl = "<CR>",
		},
	},
}
