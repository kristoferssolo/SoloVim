return {
	cmd = function(dispatchers, config)
		-- jinja-lsp resolves its config and template paths from the process cwd.
		return vim.lsp.rpc.start({ "jinja-lsp" }, dispatchers, { cwd = config.root_dir })
	end,
	filetypes = { "askama", "jinja", "htmldjango" },
	root_markers = { "jinja-lsp.toml", "Cargo.toml", "pyproject.toml", ".git" },
	-- Read project settings from disk; init_options would override them.
}
