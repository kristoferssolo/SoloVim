local nmap = require("solo.mappings").nmap
local xmap = require("solo.mappings").xmap
local vmap = require("solo.mappings").vmap
local tmap = require("solo.mappings").tmap

vim.keymap.set("", "<space>", "<nop>")
nmap("Q", "<nop>")
nmap("q", "<nop>")
nmap("<C-space>", "<nop>")

nmap("J", "mzJ`z")
nmap("<C-d>", "<C-d>zz")
nmap("<C-u>", "<C-u>zz")
nmap("n", "nzzzv")
nmap("N", "Nzzzv")

nmap("<C-h>", vim.cmd.TmuxNavigateLeft, "Focus window left")
nmap("<C-j>", vim.cmd.TmuxNavigateDown, "Focus window down")
nmap("<C-k>", vim.cmd.TmuxNavigateUp, "Focus window up")
nmap("<C-l>", vim.cmd.TmuxNavigateRight, "Focus window right")

nmap("<C-Up>", "<cmd>resize -2<cr>", "Resize window up")
nmap("<C-Down>", "<cmd>resize +2<cr>", "Resize window down")
nmap("<C-Left>", "<cmd>vertical resize -2<cr>", "Resize window left")
nmap("<C-Right>", "<cmd>vertical resize +2<cr>", "Resize window right")

nmap("<C-f>", "<cmd>!tmux neww tmux-sessionizer<cr>", "Open tmux sessionizer")

nmap("<A-k>", "<cmd>m .-2<cr>==", "Move line up")
nmap("<A-j>", "<cmd>m .+1<cr>==", "Move line down")

nmap("<S-s>", ":%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>", "[S]ubstitute word")
-- nmap("<C-b>", "<cmd>w!<cr><cmd>!compiler '%:p'<cr>")
-- nmap("<C-o>", "<cmd>w!<cr><cmd>!opout '%:p'<cr>")

xmap("p", '"_dP')
vim.keymap.set(
	"c",
	"<C-j>",
	'pumvisible() ? "\\<C-n>" : "\\<C-j>"',
	{ expr = true, noremap = true, desc = "Prev command" }
)
vim.keymap.set(
	"c",
	"<C-k>",
	'pumvisible() ? "\\<C-p>" : "\\<C-k>"',
	{ expr = true, noremap = true, desc = "Next command" }
)

vmap(">", ">gv", "Right Indent")
vmap("<", "<gv", "Left Indent")
vmap("<A-k>", ":m '<-2<cr>gv=gv", "Move lines up")
vmap("<A-j>", ":m '>+1<cr>gv=gv", "Move lines down")

tmap("t", "<C-h>", "<C-\\><C-N><C-w>h")
tmap("t", "<C-j>", "<C-\\><C-N><C-w>j")
tmap("t", "<C-k>", "<C-\\><C-N><C-w>k")
tmap("t", "<C-l>", "<C-\\><C-N><C-w>l")
