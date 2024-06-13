return {
	"toppair/peek.nvim",
	event = { "VeryLazy" },
	build = "deno task --quiet build:fast",
	config = function(_, opts)
		require("peek").setup(opts)
		vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
		vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
	end,
	opts = {
		auto_load = true,
		close_on_bdelete = true,
		syntax = true,
		theme = "dark",
		update_on_change = true,
		app = "browser",
		filetype = { "markdown", "vimwiki" },
		throttle_at = 200000,
		throttle_time = "auto",
	},
}
