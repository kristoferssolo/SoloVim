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

-- nmap("<C-f>", "<cmd>!tmux neww tmux-sessionizer<cr>", "Open tmux sessionizer")

nmap("<A-k>", "<cmd>m .-2<cr>==", "Move line up")
nmap("<A-j>", "<cmd>m .+1<cr>==", "Move line down")

-- nmap("<S-s>", ":%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>", "[S]ubstitute word")
nmap("<S-s>", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "[S]ubstitute word")

nmap("Q", "@qj", "Run macro")

nmap("<leader>oo", "<cmd>update<cr><cmd>source<cr>", "Source current file")

-- vim.keymap.set({ "n", "v", "x" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
-- vim.keymap.set("n", "<leader>Y", '"+yy', { desc = "Yank line to system clipboard" })

-- vim.keymap.set({ "n", "v", "x" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })
-- vim.keymap.set("n", "<leader>P", '"+P', { desc = "Paste before cursor from system clipboard" })


vim.keymap.set("n", "<leader>cf", function()
	local file_path = vim.fn.expand("%:p")
	vim.cmd([[call setreg("+", "]] .. vim.fn.escape(file_path, '\\ "') .. '")')
	print("Copied current file path to clipboard: " .. vim.fn.expand("%:p"))
end, { desc = "Copy file path to clipboard" })

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

local function fzf_sesh_connect()
	-- build the fzf-tmux command exactly as in your zsh widget
	local fzf_cmd = [[
sesh list --icons | fzf-tmux -p 80%,70% \
  --no-sort --ansi \
  --border-label ' sesh ' \
  --prompt '⚡  ' \
  --header '  ^a all  ^t tmux  ^g configs  ^x zoxide  ^d tmux kill  ^f find' \
  --bind 'tab:down,btab:up' \
  --bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list --icons)' \
  --bind 'ctrl-t:change-prompt(🪟  )+reload(sesh list -t --icons)' \
  --bind 'ctrl-g:change-prompt(⚙️  )+reload(sesh list -c --icons)' \
  --bind 'ctrl-x:change-prompt(📁  )+reload(sesh list -z --icons)' \
  --bind 'ctrl-f:change-prompt(🔎  )+reload(fd -H -d 2 -t d -E .Trash . ~)' \
  --bind 'ctrl-d:execute(tmux kill-session -t {2..})+change-prompt(⚡  )+reload(sesh list --icons)' \
  --preview-window 'right:55%' \
  --preview 'sesh preview {}'
]]

	-- spawn fzf-tmux, read its output
	local handle = io.popen(fzf_cmd)
	if not handle then
		vim.notify("Failed to launch fzf-tmux", vim.log.levels.ERROR)
		return
	end
	local session = handle:read("*a")
	handle:close()

	-- trim trailing newline/whitespace
	session = session:gsub("%s+$", "")

	if session == "" then
		-- user cancelled or no selection
		return
	end

	-- execute the tmux connect command
	-- opens a shell command in the current Neovim window
	vim.cmd('!sesh connect "' .. session .. '"')
end

-- bind <C-f> in Normal mode to our function
nmap("<C-f>", fzf_sesh_connect)
