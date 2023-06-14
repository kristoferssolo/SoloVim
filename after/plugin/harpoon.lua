local status_ok, harpoon = pcall(require, "harpoon")
if not status_ok then
	return
end
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

harpoon.setup()

local keymap = vim.keymap.set
local opts = { silent = true }

for i = 1, 12, 1 do
	keymap("n", "<F" .. i .. ">", function()
		ui.nav_file(i)
	end)
end
