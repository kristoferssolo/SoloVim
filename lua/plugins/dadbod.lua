return {
	"kristijanhusak/vim-dadbod-ui",
	dependencies = {
		{ "tpope/vim-dadbod", lazy = true },
		{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true }, -- Optional
		{ "tpope/vim-dotenv" },
	},
	keys = {
		{
			"<leader>od",
			vim.cmd.DBUIToggle,
			desc = "Toggle DBUI",
		},
	},
	cmd = {
		"DBUI",
		"DBUIToggle",
		"DBUIAddConnection",
		"DBUIFindBuffer",
	},
	init = function()
		vim.g.db_ui_use_nerd_fonts = 1
		local group = vim.api.nvim_create_augroup("config_dadbod_notifications", { clear = true })
		local function notification_colors()
			-- DBUI's fallback inverts Normal colors when the background is transparent.
			vim.api.nvim_set_hl(0, "NotificationInfo", { link = "Normal" })
		end
		vim.api.nvim_create_autocmd("ColorScheme", {
			group = group,
			callback = notification_colors,
		})
		vim.api.nvim_create_autocmd("WinNew", {
			group = group,
			callback = function()
				-- DBUI assigns the notification highlight after creating its window.
				vim.schedule(function()
					for _, win in ipairs(vim.api.nvim_list_wins()) do
						if vim.wo[win].winhighlight:match("Normal:Notification%w+") then
							vim.api.nvim_win_set_config(win, { border = "rounded" })
						end
					end
				end)
			end,
		})
		notification_colors()
	end,
	config = function()
		local root = vim.fs.root(vim.fn.getcwd(), ".git") or vim.fn.getcwd()
		vim.g.db_ui_save_location = vim.fn.expand("~/.local/share/db_ui/") .. vim.fs.basename(root)
	end,
}
