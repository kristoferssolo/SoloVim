local bind = vim.keymap.set
local opts = { silent = true }

--Remap space as leader key
bind("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
bind("n", "<C-d>", "<C-d>zz", opts)
bind("n", "<C-u>", "<C-u>zz", opts)
bind("n", "n", "nzzzv", opts)
bind("n", "N", "Nzzzv", opts)

-- Better window navigation with tmux
bind("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", opts)
bind("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", opts)
bind("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", opts)
bind("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", opts)

-- Resize with arrows
bind("n", "<C-Up>", "<cmd>resize -2<cr>", opts)
bind("n", "<C-Down>", "<cmd>resize +2<cr>", opts)
bind("n", "<C-Left>", "<cmd>vertical resize -2<cr>", opts)
bind("n", "<C-Right>", "<cmd>vertical resize +2<cr>", opts)

-- -- Navigate buffers
-- bind("n", "<S-l>", "<cmd>bnext<cr>", opts)
-- bind("n", "<S-h>", "<cmd>bprevious<cr>", opts)

-- Better paste
bind("v", "p", '"_dP', opts)

-- Move current line / block with Alt-j/k ala vscode
bind("n", "<A-j>", "<cmd>m .+1<cr>==", opts)
bind("n", "<A-k>", "<cmd>m .-2<cr>==", opts)

-- QuickFix
bind("n", "]q", "<cmd>cnext<cr>", opts)
bind("n", "[q", "<cmd>cprev<cr>", opts)

bind("n", "<S-s>", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", {})

bind("n", "<S-j>", "mzJ`z")

-- Insert --
-- Press jk fast to enter
bind("i", "jk", "<ESC>", opts)

-- Move current line / block with Alt-j/k ala vscode.
bind("i", "<A-j>", "<Esc><cmd>m .+1<cr>==gi", opts)
bind("i", "<A-k>", "<Esc><cmd>m .-2<cr>==gi", opts)
-- navigation
bind("i", "<A-Up>", "<C-\\><C-N><C-w>k", opts)
bind("i", "<A-Down>", "<C-\\><C-N><C-w>j", opts)
bind("i", "<A-Left>", "<C-\\><C-N><C-w>h", opts)
bind("i", "<A-Right>", "<C-\\><C-N><C-w>l", opts)

-- Visual --
-- Stay in indent mode
bind("v", "<", "<gv", opts)
bind("v", ">", ">gv", opts)

-- bind("v", "<A-j>", "<cmd>m '>+1<cr>gv=gv")
-- bind("v", "<A-k>", "<cmd>m '<-2<cr>gv=gv")

-- Visual Block --
-- Move current line / block with Alt-j/k ala vscode.
-- bind("x", "<A-j>", "<cmd>move '>+1<cr>gv-gv", opts)
-- bind("x", "<A-k>", "<cmd>move '<-2<cr>gv-gv", opts)

-- Command --
-- navigate tab completion with <c-j> and <c-k>
-- runs conditionally
bind("c", "<C-j>", 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true, noremap = true })
bind("c", "<C-k>", 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true, noremap = true })

-- Terminal --
-- Terminal window navigation
bind("t", "<C-h>", "<C-\\><C-N><C-w>h", opts)
bind("t", "<C-j>", "<C-\\><C-N><C-w>j", opts)
bind("t", "<C-k>", "<C-\\><C-N><C-w>k", opts)
bind("t", "<C-l>", "<C-\\><C-N><C-w>l", opts)

bind("n", "<C-b>", "<cmd>w!<cr><cmd>!compiler '%:p'<cr>")
bind("n", "<C-o>", "<cmd>w!<cr><cmd>!opout '%:p'<cr>")
