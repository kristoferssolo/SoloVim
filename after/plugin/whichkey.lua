if not pcall(require, "which-key") then
	return
end

local which_key = require("which-key")
local builtin = require("telescope.builtin")
local extensions = require("telescope").extensions
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
local vmappings = {}

local mappings = {
	c = { vim.cmd.bdelete, "[C]lose Buffer" },
	x = { "<cmd>!chmod +x %<cr>", "chmod & run" },
	mr = { "<cmd>CellularAutomaton make_it_rain<cr>", "[M]ake it [R]ain" },
	u = { vim.cmd.UndotreeToggle, "Toggle [U]ndotree" },
	T = { vim.cmd.TagbarToggle, "Toggle [T]agbar" },
	["/"] = {
		function()
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({ previewer = false }))
		end,
		"Current Buffer Fuzzy",
	},
	f = {
		function()
			builtin.find_files(require("telescope.themes").get_dropdown({ previewer = false }))
		end,
		"Find [F]iles",
	},
	F = { builtin.live_grep, "Live Grep" },
	b = { builtin.buffers, "Find [B]uffers" },
	ha = { require("harpoon.mark").add_file, "[H]arpoon [A]dd File" },
	hm = { require("harpoon.ui").toggle_quick_menu, "[H]arpoon [M]enu" },
	s = {
		name = "Telescope [S]earch",
		s = { builtin.grep_string, "[S]tring under the cursor" },
		e = { builtin.symbols, "[E]moji" },
		d = { builtin.diagnostic, "[D]iagnostics" },
		b = { builtin.git_branches, "Checkout [B]ranch" },
		h = { builtin.help_tags, "[H]elp" },
		M = { builtin.man_pages, "[M]an Pages" },
		r = { builtin.oldfiles, "Open [R]ecent Files" },
		R = { builtin.registers, "[R]egisters" },
		g = { builtin.live_grep, "[G]rep" },
		G = { builtin.git_files, "[G]it Files" },
		k = { builtin.keymaps, "[K]eymaps" },
		C = { builtin.commands, "[C]ommands" },
		t = { vim.cmd.TodoTelescope, "[T]odo" },
		m = { extensions.media_files.media_files, "[M]edia" },
		c = {
			function()
				builtin.colorscheme({ enable_preview = true })
			end,
			"[C]olorscheme with Preview",
		},
		l = { extensions.lazy.lazy, "[L]azy" },
		L = { extensions.luasnip.luasnip, "[L]uasnip" },
		D = {
			name = "[D]evelopment",
			s = { "<cmd>Telescope software-licenses find<cr>", "[S]oftware Licenses" },
			h = { extensions.http.list, "[H]TTP" },
		},
		H = { extensions.heading.heading, "[H]eading" },
	},
	gg = { vim.cmd.LazyGit, "Lazygit" },
	gb = {
		function()
			vim.cmd.Gitsigns("blame_line")
		end,
		"[G]it [B]lame",
	},
	gw = { require("telescope").extensions.git_worktree.git_worktrees, "[G]it Change [W]orktree" },
	gn = { require("telescope").extensions.git_worktree.create_git_worktree, "[G]it Create [N]ew Worktree" },
	gd = { require("telescope").extensions.git_diffs.diff_commits, "[G]it [D]iff" },
	l = {
		name = "[L]SP",
		ca = { vim.lsp.buf.code_action, "[C]ode [A]ction" },
		D = { vim.lsp.buf.type_definition, "Type [D]efinitions" },
		f = {
			function()
				vim.lsp.buf.format({ async = true })
			end,
			"[F]ormat",
		},
		o = { vim.diagnostic.open_float, "[O]pen Float" },
		s = { vim.diagnostic.setloclist, "[S]etloclist" },
		j = {
			function()
				vim.diagnostic.goto_next()
				vim.cmd("norm zz")
			end,
			"Next Diagnostic",
		},
		k = {
			function()
				vim.diagnostic.goto_prev()
				vim.cmd("norm zz")
			end,
			"Prev Diagnostic",
		},
		r = { vim.lsp.buf.rename, "[R]ename" },
		ds = { builtin.lsp_document_symbols, "[D]ocument [S]ymbols" },
		w = {
			d = { builtin.diagnostics, "[W]orkspace [D]iagnostics" },
			s = { builtin.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols" },
			a = { vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder" },
			r = { vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder" },
			l = {
				function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end,
				"[W]orkspace [L]ist Folder",
			},
		},
		q = { builtin.quickfix, "Telescope [Q]uickfix" },
	},
	r = {
		name = "[R]ust",
		e = { vim.cmd.RustExpandMacro, "[E]xpand macro" },
		c = { vim.cmd.RustOpenCargo, "Open [C]argo.toml" },
		p = { vim.cmd.RustParentModule, "[P]arent module" },
		h = { vim.cmd.RustHoverActions, "[H]over actions" },
		g = { vim.cmd.RustViewCrateGraph, "View Create [G]raph" },
		d = { vim.cmd.RustOpenExternalDocs, "Open External [D]ocs" },
		r = { vim.cmd.RustRunnables, "Open [R]unnables" },
		ca = { vim.cmd.RustCodeAction, "[C]ode [A]ction Groups" },
	},
	L = {
		name = "[L]anguage settings",
		c = { "<cmd>setlocal formatoptions-=cro<cr>", "Disable autocomment" },
		C = { "<cmd>setlocal formatoptions=cro<cr>", "Enable autocomment" },
		s = { "<cmd>setlocal spell!<cr>", "Toggle spellchecker" },
		e = { "<cmd>setlocal spell spelllang=en_us<cr>", "Enable English spellchecker" },
		l = { "<cmd>setlocal spell spelllang=lv_LV<cr>", "Enable Lavian spellchecker" },
		I = { "<cmd>setlocal autoindent<cr>", "Enable autoindent" },
		i = { "<cmd>setlocal noautoindent<cr>", "Disable autoindent" },
	},
	d = {
		name = "[D]AP",
		d = { require("dap").toggle_breakpoint, "Set breakpoint" },
		D = {
			function()
				require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end,
			"Set Breakpoint with Condition",
		},
		p = {
			name = "[P]ython",
			m = { require("dap-python").test_method, "Test [M]ethod" },
			c = { require("dap-python").test_class, "Test [C]lass" },
			s = { require("dap-python").debug_selection, "Debug [S]election" },
		},
		r = {
			name = "[R]ust",
			d = { vim.cmd.RustDebuggables, "[D]ebug" },
		},
		t = { require("dapui").toggle, "[T]oggle DAP-UI" },
		c = { require("dap").continue, "Launch Debug Sessions and Resume Execution" },
		i = { require("dap").step_into, "Step [I]nto Code" },
		o = { require("dap").step_over, "Step [O]ver Code" },
		O = { require("dap").step_out, "Step [O]ut of Code" },
		T = { require("dap").terminate, "[T]erminate" },
		l = { require("dap").run_last, "Run [L]ast" },
		h = { require("dap.ui.widgets").hover, "[H]over" },
		P = { require("dap.ui.widgets").preview, "[P]review" },
		f = {
			function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.frames)
			end,
			"[F]rames",
		},
		s = {
			function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.scopes)
			end,
			"[S]copes",
		},
	},
	w = {
		name = "Vim[W]iki",
		w = { vim.cmd.VimwikiIndex, "Open index file" },
		t = { vim.cmd.VimwikiTabIndex, "Open Index File in New [T]ab" },
		s = { vim.cmd.VimwikiUISelect, "Display List of Wikis" },
		i = { vim.cmd.VimwikiDiaryIndex, "Open Diary Index" },
		h = { vim.cmd.Vimwiki2HTML, "Convert File to HTML" },
		H = { vim.cmd.Vimwiki2HTMLBrowse, "Convert File to HTML and open in Browser" },
		n = { vim.cmd.VimwikiGoto, "Goto link provided by an argument" },
		d = { vim.cmd.VimwikiDeleteFile, "Rename file" },
		r = { vim.cmd.VimwikiRenameFile, "Delete file" },
	},
	t = {
		name = "Vim[T]ex",
		b = { vim.cmd.VimtexCompile, "[B]uild" },
		v = { vim.cmd.VimtexView, "[V]iew" },
		w = { vim.cmd.VimtexCountWords, "[W]ord Count" },
		t = { vim.cmd.VimtexTocToggle, "[T]able of Contents" },
		c = { vim.cmd.VimtexClean, "[C]lean aux" },
		e = { vim.cmd.VimtexErrors, "Report [E]rrors" },
		i = { vim.cmd.VimtexInfo, "[I]nfo" },
		B = { builtin.bibtex, "Telescope [B]ibtex" },
	},
	p = {
		name = "Tem[p]lates",
		l = {
			name = "[L]aTeX",
			p = {
				function()
					vim.cmd.read("~/Templates/LaTeX/PhilPaper.tex")
				end,
				"PhilPaper.tex",
			},
			l = {
				function()
					vim.cmd.read("~/Templates/LaTeX/Letter.tex")
				end,
				"Letter.tex",
			},
			g = {
				function()
					vim.cmd.read("~/Templates/LaTeX/Glossary.tex")
				end,
				"Glossary.tex",
			},
			h = {
				function()
					vim.cmd.read("~/Templates/LaTeX/HandOut.tex")
				end,
				"HandOut.tex",
			},
			b = {
				function()
					vim.cmd.read("~/Templates/LaTeX/PhilBeamer.tex")
				end,
				"PhilBeamer.tex",
			},
			s = {
				function()
					vim.cmd.read("~/Templates/LaTeX/SubFile.tex")
				end,
				"SubFile.tex",
			},
			r = {
				function()
					vim.cmd.read("~/Templates/LaTeX/Root.tex")
				end,
				"Root.tex",
			},
			m = {
				function()
					vim.cmd.read("~/Templates/LaTeX/MultipleAnswer.tex")
				end,
				"MultipleAnswer.tex",
			},
		},
		c = {
			name = "[C]make",
		},
	},
}

which_key.setup(setup)
which_key.register(mappings, opts, vopts, vmappings)
