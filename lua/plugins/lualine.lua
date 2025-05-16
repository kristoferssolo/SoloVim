return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		{
			"letieu/harpoon-lualine",
			dependencies = {
				{ "ThePrimeagen/harpoon", branch = "harpoon2" },
			},
		},
		"folke/noice.nvim",
	},
	opts = {
		options = {
			icons_enabled = true,
			theme = "auto",
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			disabled_filetypes = {
				statusline = {},
				winbar = {},
			},
			ignore_focus = {},
			always_divide_middle = false,
			globalstatus = true,
			refresh = {
				statusline = 1000,
				tabline = 1000,
				winbar = 1000,
			},
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
			lualine_a = { "mode" },
			lualine_b = { "branch" },
			lualine_c = {
				"filename",
				"diff",
				"harpoon2",
			},
			lualine_x = {
				{
					require("noice").api.statusline.mode.get,
					cond = require("noice").api.statusline.mode.has,
					color = { fg = "#f6c177" },
				},
				"diagnostics",
				"encoding",
				"filetype",
				"filesize",
			},
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { "filename" },
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {},
		winbar = {},
		inactive_winbar = {},
		extentions = {},
	},
}
