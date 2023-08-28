--Remap space as leader key
vim.g.mapleader = " "
vim.keymap.set("", "<Space>", "<nop>")
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "q", "<nop>")

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

vim.keymap.set("n", "<leader>n", vim.cmd.Ex)

vim.keymap.set("v", "<J>", ":m '>+1<cr>gv=gv")
vim.keymap.set("v", "<K>", ":m '<-2<cr>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>")
vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>")
vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>")
vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>")

vim.keymap.set("n", "<C-Up>", "<cmd>resize -2<cr>")
vim.keymap.set("n", "<C-Down>", "<cmd>resize +2<cr>")
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>")
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>")

vim.keymap.set("x", "<leader>p", '"_dP')

vim.keymap.set("n", "<C-f>", "<cmd>!tmux neww tmux-sessionizer<cr>")

vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==")
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==")

vim.keymap.set("n", "<leader>j", "<cmd>lua vim.diagnostic.goto_next()<cr>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lua vim.diagnostic.goto_prev()<cr>zz")
vim.keymap.set("n", "<leader>r", function()
	vim.lsp.buf.rename()
end)

vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<cr>", { silent = true })

vim.keymap.set("i", "<A-Up>", "<C-\\><C-N><C-w>k")
vim.keymap.set("i", "<A-Down>", "<C-\\><C-N><C-w>j")
vim.keymap.set("i", "<A-Left>", "<C-\\><C-N><C-w>h")
vim.keymap.set("i", "<A-Right>", "<C-\\><C-N><C-w>l")

vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

vim.keymap.set("c", "<C-j>", 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true, noremap = true })
vim.keymap.set("c", "<C-k>", 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true, noremap = true })

vim.keymap.set("t", "<C-h>", "<C-\\><C-N><C-w>h")
vim.keymap.set("t", "<C-j>", "<C-\\><C-N><C-w>j")
vim.keymap.set("t", "<C-k>", "<C-\\><C-N><C-w>k")
vim.keymap.set("t", "<C-l>", "<C-\\><C-N><C-w>l")

vim.keymap.set("n", "<C-b>", "<cmd>w!<cr><cmd>!compiler '%:p'<cr>")
vim.keymap.set("n", "<C-o>", "<cmd>w!<cr><cmd>!opout '%:p'<cr>")

vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomation make_it_rain<cr>")
