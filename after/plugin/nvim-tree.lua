local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	return
end

local function on_attach(bufnr)
	local api_status_ok, api = pcall(require, "nvim-tree.api")
	if not api_status_ok then
		return
	end

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end
	local keymap = vim.keymap.set

	-- Default mappings. Feel free to modify or remove as you wish.
	--
	-- BEGIN_DEFAULT_ON_ATTACH
	keymap("n", "<C-]>", api.tree.change_root_to_node, opts("CD"))
	keymap("n", "<C-e>", api.node.open.replace_tree_buffer, opts("Open: In Place"))
	keymap("n", "<C-k>", api.node.show_info_popup, opts("Info"))
	keymap("n", "<C-r>", api.fs.rename_sub, opts("Rename: Omit Filename"))
	keymap("n", "<C-t>", api.node.open.tab, opts("Open: New Tab"))
	keymap("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
	keymap("n", "x", api.node.open.horizontal, opts("Open: Horizontal Split"))
	keymap("n", "<BS>", api.node.navigate.parent_close, opts("Close Directory"))
	keymap("n", "<cr>", api.node.open.edit, opts("Open"))
	keymap("n", "<Tab>", api.node.open.preview, opts("Open Preview"))
	keymap("n", ">", api.node.navigate.sibling.next, opts("Next Sibling"))
	keymap("n", "<", api.node.navigate.sibling.prev, opts("Previous Sibling"))
	keymap("n", ".", api.node.run.cmd, opts("Run Command"))
	keymap("n", "-", api.tree.change_root_to_parent, opts("Up"))
	keymap("n", "a", api.fs.create, opts("Create"))
	keymap("n", "bmv", api.marks.bulk.move, opts("Move Bookmarked"))
	keymap("n", "B", api.tree.toggle_no_buffer_filter, opts("Toggle No Buffer"))
	keymap("n", "c", api.fs.copy.node, opts("Copy"))
	keymap("n", "C", api.tree.toggle_git_clean_filter, opts("Toggle Git Clean"))
	keymap("n", "[c", api.node.navigate.git.prev, opts("Prev Git"))
	keymap("n", "]c", api.node.navigate.git.next, opts("Next Git"))
	keymap("n", "d", api.fs.remove, opts("Delete"))
	keymap("n", "D", api.fs.trash, opts("Trash"))
	keymap("n", "E", api.tree.expand_all, opts("Expand All"))
	keymap("n", "e", api.fs.rename_basename, opts("Rename: Basename"))
	keymap("n", "]e", api.node.navigate.diagnostics.next, opts("Next Diagnostic"))
	keymap("n", "[e", api.node.navigate.diagnostics.prev, opts("Prev Diagnostic"))
	keymap("n", "F", api.live_filter.clear, opts("Clean Filter"))
	keymap("n", "f", api.live_filter.start, opts("Filter"))
	keymap("n", "g?", api.tree.toggle_help, opts("Help"))
	keymap("n", "gy", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
	keymap("n", "H", api.tree.toggle_hidden_filter, opts("Toggle Dotfiles"))
	keymap("n", "I", api.tree.toggle_gitignore_filter, opts("Toggle Git Ignore"))
	keymap("n", "J", api.node.navigate.sibling.last, opts("Last Sibling"))
	keymap("n", "K", api.node.navigate.sibling.first, opts("First Sibling"))
	keymap("n", "m", api.marks.toggle, opts("Toggle Bookmark"))
	keymap("n", "o", api.node.open.edit, opts("Open"))
	keymap("n", "O", api.node.open.no_window_picker, opts("Open: No Window Picker"))
	keymap("n", "p", api.fs.paste, opts("Paste"))
	keymap("n", "P", api.node.navigate.parent, opts("Parent Directory"))
	keymap("n", "q", api.tree.close, opts("Close"))
	keymap("n", "r", api.fs.rename, opts("Rename"))
	keymap("n", "R", api.tree.reload, opts("Refresh"))
	keymap("n", "s", api.node.run.system, opts("Run System"))
	keymap("n", "S", api.tree.search_node, opts("Search"))
	keymap("n", "U", api.tree.toggle_custom_filter, opts("Toggle Hidden"))
	keymap("n", "W", api.tree.collapse_all, opts("Collapse"))
	keymap("n", "x", api.fs.cut, opts("Cut"))
	keymap("n", "y", api.fs.copy.filename, opts("Copy Name"))
	keymap("n", "Y", api.fs.copy.relative_path, opts("Copy Relative Path"))
	keymap("n", "<2-LeftMouse>", api.node.open.edit, opts("Open"))
	keymap("n", "<2-RightMouse>", api.tree.change_root_to_node, opts("CD"))

	-- You will need to insert "your code goes here" for any mappings with a custom action_cb
	keymap("n", "l", api.node.open.edit, opts("Open"))
end

nvim_tree.setup({
	on_attach = on_attach,
	update_focused_file = {
		enable = true,
		update_cwd = true,
	},
	renderer = {
		root_folder_modifier = ":t",
		icons = {
			glyphs = {
				default = "",
				symlink = "",
				folder = {
					arrow_open = "",
					arrow_closed = "",
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
					symlink_open = "",
				},
				git = {
					unstaged = "",
					staged = "S",
					unmerged = "",
					renamed = "➜",
					untracked = "U",
					deleted = "",
					ignored = "◌",
				},
			},
		},
	},
	diagnostics = {
		enable = true,
		show_on_dirs = true,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	view = {
		width = 30,
		-- height = 30,
		side = "left",
	},
})
