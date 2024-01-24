vim.api.nvim_create_user_command("CopilotToggle", function()
	if vim.g.copilot_enabled == 1 then
		vim.g.copilot_enabled = 0
		vim.api.nvim_echo({ { "Copilot disabled", "WarningMsg" } }, true, {})
	else
		vim.g.copilot_enabled = 1
		vim.api.nvim_echo({ { "Copilot enabled", "WarningMsg" } }, true, {})
	end
end, { desc = "Toggle Copilot" })
