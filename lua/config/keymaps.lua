local function make_mapper(mode)
	return function(keys, func, desc, opts)
		vim.keymap.set(mode, keys, func, vim.tbl_extend("force", { desc = desc }, opts or {}))
	end
end

local map = make_mapper("")
local nmap = make_mapper("n") -- normal
local imap = make_mapper("i") -- insert
local vmap = make_mapper("v") -- visual
local xmap = make_mapper("x") -- visual block
local tmap = make_mapper("t") -- term
local cmap = make_mapper("c") -- command

-- Unmap keys
map("<space>", "<nop>")
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

local function wrap_move(key, gkey)
	return function()
		return vim.v.count == 0 and gkey or key
	end
end
nmap("j", wrap_move("j", "gj"), "Navigate wrapped lines", { expr = true, silent = true })
nmap("k", wrap_move("k", "gk"), "Navigate wrapped lines", { expr = true, silent = true })

nmap("<C-Up>", "<cmd>resize -2<cr>", "Resize window up")
nmap("<C-Down>", "<cmd>resize +2<cr>", "Resize window down")
nmap("<C-Left>", "<cmd>vertical resize -2<cr>", "Resize window left")
nmap("<C-Right>", "<cmd>vertical resize +2<cr>", "Resize window right")

nmap("<S-s>", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "[S]ubstitute word")

nmap("Q", "@qj", "Run q macro")

nmap("<leader>oo", "<cmd>update<cr><cmd>source<cr>", "Source current file")

nmap("<leader>cf", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	print("Copied" .. path)
end, "Copy file path to clipboard")

xmap("Q", ":norm @q<CR>", "Run macro")
xmap("p", '"_dP')

cmap("<C-j>", 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', "Prev command", { expr = true, noremap = true })
cmap("<C-k>", 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', "Next command", { expr = true, noremap = true })

vmap(">", ">gv", "Right Indent")
vmap("<", "<gv", "Left Indent")
vmap("<A-k>", ":m '<-2<cr>gv=gv", "Move lines up")
vmap("<A-j>", ":m '>+1<cr>gv=gv", "Move lines down")

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

	vim.system({ "bash", "-c", fzf_cmd }, { text = true }, function(result)
		if result.code ~= 0 or not result.stdout then
			return
		end

		local session = vim.trim(result.stdout)
		if session == "" then
			return
		end

		vim.schedule(function()
			vim.system({ "sesh", "connect", session }, { text = true }, function(r)
				if r.code ~= 0 and r.stderr and r.stderr ~= "" then
					vim.notify("sesh connect failed: " .. r.stderr, vim.log.levels.ERROR)
				end
			end)
		end)
	end)
end

nmap("<C-f>", fzf_sesh_connect)
