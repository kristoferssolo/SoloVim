return {
	"nvim-neorg/neorg",
	dependencies = {
		{ "vhyrro/luarocks.nvim", config = true },
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-neorg/neorg-telescope" },
	},
	cmd = { "Neorg" },
	lazy = true,
	version = "*",
	ft = "norg",
	opts = {
		load = {
			["core.defaults"] = {}, -- Loads default behaviour
			["core.concealer"] = {}, -- Adds pretty icons to your documents
			["core.dirman"] = { -- Manages Neorg workspaces
				config = {
					workspaces = {
						university = "~/neorg/University",
						work = "~/neorg/Work",
					},
					default_workspace = "work",
				},
			},
			["core.completion"] = {
				config = {
					engine = "nvim-cmp",
					name = "[Neorg]",
				},
			},
			["core.export"] = {},
			-- ["core.export.markdown"] = {},
			["core.summary"] = {
				config = {
					strategy = "default",
				},
			},
			-- ["core.ui.calendar"] = {},
			["core.integrations.telescope"] = {
				config = {
					insert_file_link = {
						-- Whether to show the title preview in telescope. Affects performance with a large
						-- number of files.
						show_title_preview = true,
					},
				},
			},
		},
	},
}
