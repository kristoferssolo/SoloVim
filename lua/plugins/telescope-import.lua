local ft = { "typescript", "typescriptreact", "javascript", "react", "python", "lua" }
return {
	"piersolenski/telescope-import.nvim",
	dependencies = "nvim-telescope/telescope.nvim",
	commit = "e60ca0fea71432ed578e17d8f1b153da3fa4555d",
	ft = ft,
	keys = {
		{
			"<leader>li",
			function()
				vim.cmd.Telescope("import")
			end,
			desc = "[I]mport",
			ft = ft,
		},
	},
	opts = {
		extensions = {
			import = {
				insert_at_top = true,
				custom_languages = {
					{
						regex = [[^(?:import(?:[\"'\s]*([\w*{}\n, ]+)from\s*)?[\"'\s](.*?)[\"'\s].*)]],
						filetypes = ft,
						extensions = { "js", "ts", "py", "lua" },
					},
				},
			},
		},
	},
	config = function(_, opts)
		require("telescope").load_extension("import", opts)
	end,
}
