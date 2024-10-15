return {
	"alexpasmantier/pymple.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		-- "stevearc/dressing.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	build = ":PympleBuild",
	config = function()
		require("pymple").setup()
	end,
	opts = {
		-- automatically register the following keymaps on plugin setup
		keymaps = {
			-- Resolves import for symbol under cursor.
			-- This will automatically find and add the corresponding import to
			-- the top of the file (below any existing doctsring)
			resolve_import_under_cursor = {
				desc = "Resolve import under cursor",
				keys = "<leader>li", -- feel free to change this to whatever you like
			},
		},
	},
}
