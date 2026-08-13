vim.opt.number = true -- line number
vim.opt.relativenumber = true -- relative line numbers
vim.opt.cursorline = true -- highlight current line
-- vim.opt.cursorcolumn = false -- highlight the current column
vim.opt.wrap = false -- do not wrap lines by default
vim.opt.scrolloff = 10 -- keep 10 lines above/below cursor
vim.opt.sidescrolloff = 10 -- keep 10 lines to left/right of cursor
vim.opt.termguicolors = true -- set term gui colors (most terminals support this)

vim.opt.tabstop = 4 -- tabwidth
vim.opt.shiftwidth = 4 -- indent width
vim.opt.softtabstop = 4 -- soft tab stop not tabs on tab/backspace
vim.opt.expandtab = true -- use spaces instead of tabs
vim.opt.smartindent = true -- smart auto-indent
vim.opt.autoindent = true -- copy indent from current line
vim.opt.breakindent = true -- enable break indent

vim.opt.ignorecase = true -- case insensitive search
vim.opt.smartcase = true -- case sensitive if uppercase in string
vim.opt.hlsearch = false -- highlight search matches
vim.opt.incsearch = true -- show matches as you type

vim.opt.signcolumn = "yes" --"yes:1" always show a sign column
vim.opt.colorcolumn = "120" -- show a column at 120 position chars
vim.opt.showmatch = true -- highlights matching brackets
vim.opt.cmdheight = 1 -- single line command line
vim.opt.completeopt = "menuone,noinsert,noselect" -- completion options
vim.opt.showmode = false -- do not show the mode, instead have it in statusline
vim.opt.laststatus = 3 -- global statusline at the bottom instead of one for each window
vim.opt.pumheight = 10 -- popup menu height
vim.opt.pumblend = 10 -- popup menu transparency
vim.opt.winblend = 0 -- floating window transparency
vim.opt.conceallevel = 0 -- 0 do not hide markup
vim.opt.concealcursor = "" -- do not hide cursorline in markup
-- vim.opt.lazyredraw = true -- do not redraw during macros
vim.opt.synmaxcol = 300 -- syntax highlighting limit
vim.opt.fillchars = { eob = " " } -- hide "~" on empty lines
vim.opt.list = true
vim.opt.listchars = { space = "·", tab = "▎ ", eol = "↴" }

vim.opt.backup = false -- do not create a backup file
vim.opt.writebackup = false -- do not write to a backup file
vim.opt.swapfile = false -- do not create a swapfile
vim.opt.undofile = true -- do create an undo file
vim.opt.undodir = vim.fn.stdpath("data") .. "/nvim/undodir" -- set the undo directory
vim.opt.updatetime = 300 -- faster completion
vim.opt.timeoutlen = 250 -- timeout duration
vim.opt.ttimeoutlen = 50 -- key code timeout
vim.opt.autoread = true -- auto-reload changes if outside of neovim
vim.opt.autowrite = false -- do not auto-save
vim.opt.jumpoptions = "view" -- preserves viewport more nicely across jumps

vim.opt.hidden = true -- allow hidden buffers
vim.opt.errorbells = false -- no error sounds
vim.opt.backspace = "indent,eol,start" -- better backspace behaviour
vim.opt.autochdir = false -- do not autochange directories
vim.opt.iskeyword:append("-") -- include - in words
vim.opt.path:append("**") -- include subdirs in search
vim.opt.path:prepend(vim.fn.stdpath("config") .. "/lua")
vim.opt.selection = "inclusive" -- include last char in selection
vim.opt.mouse = "a" -- enable mouse support
vim.opt.clipboard:append("unnamedplus") -- use system clipboard
-- vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
vim.opt.showtabline = 0 -- disable tabs
vim.opt.modifiable = true -- allow buffer modifications
vim.opt.encoding = "utf-8" -- set encoding
vim.opt.fileencoding = "utf-8" -- the encoding written to a file
vim.opt.spell = false
vim.opt.spelloptions:append("camel")

-- folding: requires treesitter available at runtime; safe fallback if not
vim.opt.foldenable = true
vim.opt.foldmethod = "expr" -- use expression for folding
-- vim.opt.foldmethod = "manual"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- use treesitter for folding
vim.opt.foldlevel = 99 -- start with all folds open
vim.opt.foldcolumn = "0" -- '0' is not bad

vim.opt.splitbelow = true -- horizontal splits go below
vim.opt.splitright = true -- vertical splits go right

vim.opt.wildmenu = true -- tab completion
-- vim.opt.wildmode = "longest:full,full" -- complete longest common match, full completion list, cycle through with tab
vim.opt.diffopt:append("linematch:60") -- improve diff display
vim.opt.redrawtime = 10000 -- increase neovim redraw tolerance
vim.opt.maxmempattern = 20000 -- increase max memory

--- Legacy
-- vim.opt.guifont = "JetBrainsMono NF:h11" -- the font used in graphical neovim applications
-- vim.opt.isfname:append("@-@")
-- vim.opt.sessionoptions:append("globals")
-- vim.opt.shortmess:append("c")
-- vim.opt.showcmd = false
vim.opt.splitkeep = "screen" -- Makes split resizing/jumps feel less disruptive when opening quickfix, diagnostics, etc
vim.opt.suffixesadd:prepend(".lua")
vim.opt.suffixesadd:prepend("init.lua")
vim.opt.whichwrap:append("<,>,[,],h,l")

vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 0
vim.g.netrw_keepdir = 0
vim.g.netrw_localcopydircmd = "cp -r"
vim.g.netrw_winsize = 30
