if not pcall(require, "neorg") then
	return
end

require("neorg").setup({
	load = {
		["core.defaults"] = {}, -- Loads default behaviour
		["core.concealer"] = {}, -- Adds pretty icons to your documents
		["core.dirman"] = { -- Manages Neorg workspaces
			config = {
				workspaces = {
					university = "~/neorg/University",
				},
				default_workspace = "university",
			},
		},
		["core.completion"] = {
			config = {
				engine = "nvim-cmp",
				name = "[Neorg]",
			},
		},
		["core.export.markdown"] = {},
		["core.summary"] = {
			config = {
				strategy = "default",
			},
		},
		-- ["core.ui.calendar"] = {},
	},
})
