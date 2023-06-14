local attach_on_buffer = function(output_bufnr, pattern, command)
	vim.api.nvim_create_autocmd("BufWritePost", {
		group = vim.api.nvim_create_augroup("autosave", { clear = true }),
		pattern = pattern,
		callback = function()
			local append_data = function(_, data)
				if data then
					vim.api.nvim_buf_set_lines(output_bufnr, -1, -1, false, data)
				end
			end

			local file_path = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
			vim.api.nvim_buf_set_lines(output_bufnr, 0, -1, false, { file_path })
			vim.fn.jobstart(command, {
				stdout_buffered = true,
				on_stdout = append_data,
				on_stderr = append_data,
			})
		end,
	})
end

vim.api.nvim_create_user_command("AutoRun", function()
	print("AutoRun starts now...")
	local bufnr = vim.api.nvim_get_current_buf()
	local command = vim.fn.input("Command: ")
	local pattern = vim.split(vim.fn.input("Pattern: "), " ")
	attach_on_buffer(tonumber(bufnr), pattern, command)
end, {})

vim.api.nvim_create_user_command("AutoStop", function()
	vim.api.nvim_create_augroup("autosave", { clear = true })
end, {})
