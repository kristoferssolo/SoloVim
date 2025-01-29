return {
	"milanglacier/minuet-ai.nvim",
	enabled = false,
	opts = {
		end_point = "http://127.0.0.1:1234/v1/chat/completions",
		virtualtext = {
			auto_trigger_ft = {},
			keymap = {
				-- accept whole completion
				accept = "<A-A>",
				-- accept one line
				accept_line = "<A-a>",
				-- accept n lines (prompts for number)
				accept_n_lines = "<A-z>",
				-- Cycle to prev completion item, or manually invoke completion
				prev = "<A-[>",
				-- Cycle to next completion item, or manually invoke completion
				next = "<A-]>",
				dismiss = "<A-e>",
			},
		},
	},
	config = function(_, opts)
		require("minuet").setup(opts)
	end,
}
