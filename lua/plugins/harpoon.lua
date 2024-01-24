return {
	"ThePrimeagen/harpoon",
	dependencies = { "nvim-lua/plenary.nvim" },
	branch = "harpoon2",
	keys = {
		{
			"<leader>ha",
			function()
				require("harpoon"):list():append()
			end,
			desc = "[H]arpoon [A]dd File",
		},
		{
			"<leader>hm",
			function()
				local harpoon = require("harpoon")
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end,
			desc = "[H]arpoon [M]enu",
		},
	},
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup()

		vim.keymap.set("n", "<F1>", function()
			harpoon:list():select(1)
		end)
		vim.keymap.set("n", "<F2>", function()
			harpoon:list():select(2)
		end)
		vim.keymap.set("n", "<F3>", function()
			harpoon:list():select(3)
		end)
		vim.keymap.set("n", "<F4>", function()
			harpoon:list():select(4)
		end)
	end,
}
