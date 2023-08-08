return {
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = {

			options = {
				globalstatus = true,
				icons_enabled = true,
				theme = "auto",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = { "alpha", "dashboard" },
				always_divide_middle = true,
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch" },
				lualine_c = { "diff" },
				lualine_x = { "lsp_progress", "diagnostics" },
				lualine_y = { "filename" },
				lualine_z = { "location", "progress" },
			},
		},
	},
}
