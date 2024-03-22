return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"arkav/lualine-lsp-progress",
		},
		opts = {
			options = {
				component_separators = { left = "|", right = "|" },
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
				lualine_b = { "branch", "diff" },
				lualine_c = { "filename", "harpoon2", "lsp_progress" },
				lualine_x = { "diagnostics", "encoding", "filetype", "filesize" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			extentions = { "fzf", "fugitive", "lazy", "mason", "man", "oil", "nvim-dap-ui", "trouble" },
		},
	},
	{
		"letieu/harpoon-lualine",
		dependencies = {
			{
				"ThePrimeagen/harpoon",
			},
		},
	},
}
