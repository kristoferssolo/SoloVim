local which_key = require("which-key")

local setup = {
	plugins = {
		marks = true, -- shows a list of your marks on " and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = true, -- adds help for motions
			text_objects = true, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
	},
	-- add operators that will trigger motion and text object completion
	-- to enable all native operators, set the preset / operators plugin above
	-- operators = { gc = "Comments" },
	key_labels = {
		-- override the label used to display some keys. It doesn"t effect WK in any other way.
		-- For example:
		-- ["<space>"] = "SPC",
		-- ["<cr>"] = "RET",
		-- ["<tab>"] = "TAB",
	},
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it"s label
		group = "+", -- symbol prepended to a group
	},
	popup_mappings = {
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up = "<c-u>", -- binding to scroll up inside the popup
	},
	window = {
		border = "rounded", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
		winblend = 0,
	},
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
		align = "left", -- align columns left, center or right
	},
	ignore_missing = true, -- enable this to hide mappings for which you didn"t specify a label
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<cr>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
	show_help = true, -- show help message on the command line when the popup is visible
	triggers = "auto", -- automatically setup triggers
	-- triggers = {"<leader>"} -- or specify a list manually
	triggers_blacklist = {
		-- list of mode / prefixes that should never be hooked by WhichKey
		-- this is mostly relevant for key maps that start with a native binding
		-- most people should not need to change this
		i = { "j", "k" },
		v = { "j", "k" },
	},
}

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}
local vopts = {
	mode = "v", -- VISUAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}
-- NOTE: Prefer using : over <cmd> as the latter avoids going back in normal-mode.
-- see https://neovim.io/doc/user/map.html#:map-cmd
local vmappings = {
	["/"] = { "<Plug>(comment_toggle_linewise_visual)", "Comment toggle linewise (visual)" },
}

local mappings = {
	[";"] = { vim.cmd.Alpha, "Dashboard" },
	["/"] = { "<Plug>(comment_toggle_linewise_current)", "Comment toggle current line" },
	c = { vim.cmd.bdelete, "Close Buffer" },
	f = {
		"<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({previewer = false}))<cr>",
		"Find files",
	},
	e = { vim.cmd.NvimTreeToggle, "Explorer" },
	F = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
	P = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },
	b = { "<cmd>Telescope buffers<cr>", "Find Buffers" },
	u = { vim.cmd.UndotreeToggle, "UndotreeToggle" },
	t = { vim.cmd.TagbarToggle, "Toggle Tagbar" },
	m = { require("harpoon.mark").add_file, "Add file to harpoon" },
	h = { require("harpoon.ui").toggle_quick_menu, "Open harpoon menu" },
	n = { vim.cmd.Oil, "Open Oil" },
	g = {
		name = "Git",
		g = { "<cmd>lua _LAZYGIT_TOGGLE()<cr>", "Lazygit" },
		l = { "<cmd>lua require('gitsigns').blame_line()<cr>", "Blame" },
	},
	l = {
		name = "LSP",
		a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
		d = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Buffer Diagnostics" },
		w = {
			"<cmd>Telescope diagnostics<cr>",
			"Workspace Diagnostics",
		},
		j = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next Diagnostic" },
		k = {
			"<cmd>lua vim.diagnostic.goto_prev()<cr>",
			"Prev Diagnostic",
		},
		r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
		s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
		S = {
			"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
			"Workspace Symbols",
		},
		e = { "<cmd>Telescope quickfix<cr>", "Telescope Quickfix" },
	},
	s = {
		name = "Search",
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
		f = { "<cmd>Telescope find_files<cr>", "Find File" },
		h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
		H = { "<cmd>Telescope highlights<cr>", "Find highlight groups" },
		M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
		r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
		R = { "<cmd>Telescope registers<cr>", "Registers" },
		t = { "<cmd>Telescope live_grep<cr>", "Text" },
		k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
		C = { "<cmd>Telescope commands<cr>", "Commands" },
		T = { "<cmd>TodoTelescope<cr>", "Todo" },
		m = { "<cmd>lua require('telescope').extensions.media_files.media_files()<cr>", "Media" },
		p = {
			"<cmd>lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>",
			"Colorscheme with Preview",
		},
	},
	r = {
		name = "Rust",
		e = { vim.cmd.RustExpandMacro, "Expand macro" },
		c = { vim.cmd.RustOpenCargo, "Open cargo.toml" },
		p = { vim.cmd.RustParentModule, "Parent module" },
		h = { vim.cmd.RustHoverActions, "Hover actions" },
		g = { vim.cmd.RustViewCrateGraph, "View create graph" },
		d = { vim.cmd.RustOpenExternalDocs, "Open external docs" },
		R = { vim.cmd.RustRunnables, "Open runnables" },
		a = { vim.cmd.RustCodeAction, "Code action groups" },
	},
	T = {
		name = "Terminal",
		n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
		u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
		b = { "<cmd>lua _BTOP_TOGGLE()<cr>", "Btop" },
		p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
		c = { "<cmd>lua _CARGO_RUN()<cr>", "Cargo run" },
		f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
		h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
		v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
	},
	L = {
		name = "Language settings",
		c = { "<cmd>setlocal formatoptions-=cro<cr>", "Disable autocomment" },
		C = { "<cmd>setlocal formatoptions=cro<cr>", "Enable autocomment" },
		s = { "<cmd>setlocal spell!<cr>", "Toggle spellchecker" },
		e = { "<cmd>setlocal spell spelllang=en_us<cr>", "Enable English spellchecker" },
		l = { "<cmd>setlocal spell spelllang=lv_LV<cr>", "Enable Lavian spellchecker" },
		I = { "<cmd>setlocal autoindent<cr>", "Enable autoindent" },
		i = { "<cmd>setlocal noautoindent<cr>", "Disable autoindent" },
	},
	d = {
		name = "DAP",
		d = { "<cmd>lua require('dap').toggle_breakpoint()<cr>", "Set breakpoint" },
		t = { "<cmd>lua require('dapui').toggle()<cr>", "Toggle DAP-UI" },
		c = { "<cmd>lua require('dap').continue()<cr>", "Launch debug sessions and resume execution" },
		i = { "<cmd>lua require('dap').step_into()<cr>", "Step into code" },
		o = { "<cmd>lua require('dap').step_over()<cr>", "Step over code" },
		O = { "<cmd>lua require('dap').step_out()<cr>", "Step out of code" },
		r = { "<cmd>lua require('dap').repl.open()<cr>", "Inspect state" },
		T = { "<cmd>lua require('dap').terminate()<cr>", "Terminate" },
		l = { "<cmd>lua require('dap').run_last()<cr>", "Run last" },
	},
	w = {
		name = "VimWiki",
		w = { "<Plug>VimwikiIndex", "Open index file" },
		t = { "<Plug>VimwikiTabIndex", "Open index file in new tab" },
		s = { "<Plug>VimwikiUISelect", "Display list of wikis" },
		i = { "<Plug>VimwikiDiaryIndex", "Open diary index" },
		h = { "<Plug>Vimwiki2HTML", "Convert file to HTML" },
		H = { "<Plug>Vimwiki2HTMLBrowse", "Convert file to HTML and open in browser" },
		n = { "<Plug>VimwikiGoto", "Goto link provided by an argument" },
		d = { "<Plug>VimwikiDeleteFile", "Rename file" },
		r = { "<Plug>VimwikiRenameFile", "Delete file" },
	},
}

which_key.setup(setup)
which_key.register(mappings, opts, vopts, vmappings)
