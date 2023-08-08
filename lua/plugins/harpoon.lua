return {
	{
		"ThePrimeagen/harpoon",
		opts = {},
		config = function()
			local ui = require("harpoon.ui")
			local keymap = vim.keymap.set
			for i = 1, 12, 1 do
				keymap("n", "<F" .. i .. ">", function()
					ui.nav_file(i)
				end)
			end
		end,
	},
}
