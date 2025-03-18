local nmap = require("config.mappings").nmap
local xmap = require("config.mappings").xmap
local vmap = require("config.mappings").vmap
local tmap = require("config.mappings").tmap
local imap = require("config.mappings").imap

-- Unmap keys
vim.keymap.set("", "<space>", "<nop>")
nmap("Q", "<nop>")
nmap("<C-space>", "<nop>")
nmap("<F1>", "<nop>")
nmap("<F2>", "<nop>")
nmap("<F3>", "<nop>")
nmap("<F4>", "<nop>")
nmap("<leader>v", "<nop>")
nmap("<leader>p", "<nop>")

nmap("J", "mzJ`z")
nmap("<C-d>", "<C-d>zz")
nmap("<C-u>", "<C-u>zz")
nmap("n", "nzzzv")
nmap("N", "Nzzzv")
nmap("*", "*zz")
nmap("#", "#zz")
nmap("g*", "g*zz")
nmap("g#", "g#zz")
vim.keymap.set("n", ";", ";", { silent = false })

vim.keymap.set({ "n" }, "j", "gj", { desc = "Allows to navigate though wrapped lines", noremap = true })
vim.keymap.set({ "n" }, "k", "gk", { desc = "Allows to navigate though wrapped lines", noremap = true })

nmap("<C-Up>", "<cmd>resize -2<cr>", "Resize window up")
nmap("<C-Down>", "<cmd>resize +2<cr>", "Resize window down")
nmap("<C-Left>", "<cmd>vertical resize -2<cr>", "Resize window left")
nmap("<C-Right>", "<cmd>vertical resize +2<cr>", "Resize window right")

nmap("<C-f>", "<cmd>!tmux neww tmux-sessionizer<cr>", "Open tmux sessionizer")

nmap("<A-k>", "<cmd>m .-2<cr>==", "Move line up")
nmap("<A-j>", "<cmd>m .+1<cr>==", "Move line down")

-- nmap("<S-s>", ":%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>", "[S]ubstitute word")
nmap("<S-s>", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "[S]ubstitute word")

nmap("Q", "@qj", "Run macro")

xmap("Q", ":norm @q<CR>", "Run macro")

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

-- tmap("t", "<C-h>", "<C-\\><C-N><C-w>h")
-- tmap("t", "<C-j>", "<C-\\><C-N><C-w>j")
-- tmap("t", "<C-k>", "<C-\\><C-N><C-w>k")
-- tmap("t", "<C-l>", "<C-\\><C-N><C-w>l")
