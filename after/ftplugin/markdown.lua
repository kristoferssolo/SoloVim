vim.opt_local.wrap = true
vim.opt_local.spell = true
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.spelllang = "lv,en"

vim.keymap.set("n", "<leader>P", vim.cmd.ObsidianPasteImg)
-- vim.keymap.set({ "n", "v" }, ">>", vim.cmd("Heading increase"), { desc = "Increase heading level" })
-- vim.keymap.set({ "n", "v" }, "<<", vim.cmd("Heading decrease"), { desc = "Decrease heading level" })
-- vim.keymap.set({ "n", "v" }, "<C-Space>", vim.cmd("Checkbox toggle"), { desc = "Toggle checkbox", noremap = true })
-- vim.keymap.set("n", "<C-n>", vim.cmd.ObsidianQuickSwitch)
