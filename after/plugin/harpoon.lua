if not pcall(require, "harpoon") then
	return
end

local ui = require("harpoon.ui")

vim.keymap.set("n", "<F1>", function()
	ui.nav_file(1)
end)
vim.keymap.set("n", "<F2>", function()
	ui.nav_file(2)
end)
vim.keymap.set("n", "<F3>", function()
	ui.nav_file(3)
end)
vim.keymap.set("n", "<F4>", function()
	ui.nav_file(4)
end)
