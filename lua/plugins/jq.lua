return {
	"cenk1cenk2/jq.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"grapp-dev/nui-components.nvim",
	},
	opts = {
		keymap = {
			close = "<Esc>",
			focus_next = "<Tab>",
			focus_prev = "<S-Tab>",
			focus_left = "<C-h>",
			focus_right = "<C-l>",
			focus_up = "<C-k>",
			focus_down = "<C-j>",
		},
	},
	config = function(_, opts)
		require("jq").setup(opts)
		vim.api.nvim_create_user_command("JQ", function()
			require("jq").run({
				--- you can pass additional options to configure the current instance
				-- if you want to toggle from the memory
				toggle = true,
				-- commands for the instance else it will use the default
				-- the default command would be the first one in the table
				commands = {
					{
						-- command to be run
						command = "jq",
						-- filetype of the output
						filetype = "json",
						-- hidden arguments that will not be shown in the ui
						arguments = "-r",
					},
				},
				-- arguments to start with in the ui
				arguments = "",
				-- query to start with, if not provided it will use the default
				query = ".",
			})
		end, {})
	end,
}
