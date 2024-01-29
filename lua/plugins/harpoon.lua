return {
	"ThePrimeagen/harpoon",
	dependencies = { "nvim-lua/plenary.nvim" },
	branch = "harpoon2",
	keys = {
		{
			"<leader>a",
			function()
				require("harpoon"):list():append()
			end,
			desc = "Harpoon [A]dd File",
		},
		{
			"<C-e>",
			function()
				local harpoon = require("harpoon")
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end,
			desc = "Toggle Harpoon Menu",
		},
		{
			"<F1>",
			function()
				require("harpoon"):list():select(1)
			end,
			desc = "Harpoon [1]",
		},
		{
			"<F2>",
			function()
				require("harpoon"):list():select(2)
			end,
			desc = "Harpoon [2]",
		},
		{
			"<F3>",
			function()
				require("harpoon"):list():select(3)
			end,
			desc = "Harpoon [3]",
		},
		{
			"<F4>",
			function()
				require("harpoon"):list():select(4)
			end,
			desc = "Harpoon [4]",
		},
	},

	config = function()
		require("harpoon"):setup()
	end,
}
