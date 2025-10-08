--- Adds `[]` around the string
---@param str string
---@param ctx table
---@return string
local function wrap_string(str, _ctx)
	return "[" .. str:gsub("%s+", "") .. "]"
end

return {
	"nvim-lualine/lualine.nvim",
	event = "VimEnter",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		{
			"linrongbin16/lsp-progress.nvim",
			config = function()
				require("lsp-progress").setup()
			end,
		},
		{
			"kristoferssolo/lualine-harpoon.nvim",
			dependencies = {
				{
					"ThePrimeagen/harpoon",
					branch = "harpoon2",
				},
			},
		},
		"folke/noice.nvim",
	},
	opts = {
		options = {
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			color = { bg = "" },
		},
		--[[ Available components
			`branch` (git branch)
			`buffers` (shows currently available buffers)
			`diagnostics` (diagnostics count from your preferred source)
			`diff` (git diff status)
			`encoding` (file encoding)
			`fileformat` (file format)
			`filename`
			`filesize`
			`filetype`
			`hostname`
			`location` (location in file in line:column format)
			`mode` (vim mode)
			`progress` (%progress in file)
			`searchcount` (number of search matches when hlsearch is active)
			`selectioncount` (number of selected characters or lines)
			`tabs` (shows currently available tabs)
			`windows` (shows currently available windows) ]]
		sections = {
			lualine_a = {},
			lualine_b = {
				{ "mode", fmt = wrap_string },
				{ "branch" },
			},
			lualine_c = {
				{
					"filetype",
					padding = { right = 0, left = 1 },
					icon_only = true,
				},
				{
					"filename",
					padding = { right = 1, left = 0 },
				},
				"diff",
				"harpoon",
			},
			lualine_x = {
				{
					require("noice").api.statusline.mode.get,
					cond = require("noice").api.statusline.mode.has,
					color = { fg = "#f6c177" },
				},
				function()
					return require("lsp-progress").progress()
				end,
				"diagnostics",
			},
			lualine_y = {
				"filesize",
				{
					"location",
					padding = 0,
					fmt = function(str, _)
						return "[" .. str:gsub("%s+", "") .. " "
					end,
				},
				{
					"progress",
					padding = 0,
					fmt = function(str, _)
						return str:gsub("%s+", "") .. "]"
					end,
				},
			},
			lualine_z = {},
		},
	},
	config = function(_, opts)
		local lualine = require("lualine")
		lualine.setup(opts)

		-- listen lsp-progress event and refresh lualine
		vim.api.nvim_create_autocmd("User", {
			group = vim.api.nvim_create_augroup("lualine_augroup", { clear = true }),
			pattern = "LspProgressStatusUpdated",
			callback = lualine.refresh,
		})
	end,
}
