local keymap = vim.keymap.set
local opts = { silent = true }

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
keymap("n", "q", "<Nop>", opts)
keymap("n", "Q", "<Nop>", opts)
vim.g.mapleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<cr>", opts)
keymap("n", "<C-Down>", ":resize +2<cr>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<cr>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<cr>", opts)

-- -- Navigate buffers
keymap("n", "<S-l>", ":bnext<cr>", opts)
keymap("n", "<S-h>", ":bprevious<cr>", opts)

-- Better paste
keymap("v", "p", '"_dP', opts)

-- Move current line / block with Alt-j/k ala vscode
keymap("n", "<A-j>", "<cmd>m .+1<cr>==", opts)
keymap("n", "<A-k>", "<cmd>m .-2<cr>==", opts)

-- QuickFix
keymap("n", "]q", "<cmd>cnext<cr>", opts)
keymap("n", "[q", "<cmd>cprev<cr>", opts)

keymap("n", "<S-s>", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", {})

keymap("n", "<S-j>", "mzJ`z")

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Move current line / block with Alt-j/k ala vscode.
keymap("i", "<A-j>", "<Esc><cmd>m .+1<cr>==gi", opts)
keymap("i", "<A-k>", "<Esc><cmd>m .-2<cr>==gi", opts)
-- navigation
keymap("i", "<A-Up>", "<C-\\><C-N><C-w>k", opts)
keymap("i", "<A-Down>", "<C-\\><C-N><C-w>j", opts)
keymap("i", "<A-Left>", "<C-\\><C-N><C-w>h", opts)
keymap("i", "<A-Right>", "<C-\\><C-N><C-w>l", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- keymap("v", "<A-j>", "<cmd>m '>+1<cr>gv=gv")
-- keymap("v", "<A-k>", "<cmd>m '<-2<cr>gv=gv")

-- Visual Block --
-- Move current line / block with Alt-j/k ala vscode.
-- keymap("x", "<A-j>", "<cmd>move '>+1<cr>gv-gv", opts)
-- keymap("x", "<A-k>", "<cmd>move '<-2<cr>gv-gv", opts)

-- Command --
-- navigate tab completion with <c-j> and <c-k>
-- runs conditionally
keymap("c", "<C-j>", 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true, noremap = true })
keymap("c", "<C-k>", 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true, noremap = true })

-- Terminal --
-- Terminal window navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", opts)

keymap("n", "<C-b>", "<cmd>w!<cr><cmd>!compiler '%:p'<cr>")
keymap("n", "<C-o>", "<cmd>w!<cr><cmd>!opout '%:p'<cr>")
