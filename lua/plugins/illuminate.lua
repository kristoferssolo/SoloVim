return {
	"RRethy/vim-illuminate",
	event = "BufReadPost",
	keys = {
		{
			"<A-n>",
			function()
				require("illuminate").goto_next_reference()
			end,
		},
		{

			"<A-p>",
			function()
				require("illuminate").goto_prev_reference()
			end,
		},
	},
	opts = {
		filetypes_denylist = {
			"alpha",
			"NvimTree",
			"dirvish",
			"fugitive",
			"dbee",
		},
	},
	config = function(_, opts)
		require("illuminate").configure(opts)
	end,
}
