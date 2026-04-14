return {
	filetypes = { "hyprlang" },
	root_dir = function(bufnr, on_dir)
		local path = bufnr
		if type(bufnr) == "number" then
			path = vim.api.nvim_buf_get_name(bufnr)
		end
		if type(path) ~= "string" or path == "" then
			return
		end

		on_dir(vim.fs.dirname(path))
	end,
	single_file_support = true,
}
