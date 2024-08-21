return {
	"nvim-neorg/neorg",
	dependencies = {
		{ "vhyrro/luarocks.nvim", config = true },
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-neorg/neorg-telescope" },
	},
	cmd = { "Neorg" },
	keys = {
		{ "<C-Space>", "<Plug>(neorg.qol.todo-items.todo.task-cycle)", desc = "Cycle Todo Item", ft = { "norg" } },
		{
			"<LocalLeader>cm",
			"<Plug>(neorg.looking-glass.magnify-code-block)",
			desc = "Mignify Code Block",
			ft = { "norg" },
		},
		{ "<LocalLeader>id", "<Plug>(neorg.tempus.insert-date)", desc = "Insert Date", ft = { "norg" } },
		{ "<LocalLeader>li", "<Plug>(neorg.pivot.list.invert)", desc = "List invert", ft = { "norg" } },
		{ "<LocalLeader>lt", "<Plug>(neorg.pivot.list.toggle)", desc = "List Toggle", ft = { "norg" } },
		{ "<LocalLeader>nn", "<Plug>(neorg.dirman.new-note)", desc = "New Note", ft = { "norg" } },
		{
			"<LocalLeader>ta",
			"<Plug>(neorg.qol.todo-items.todo.task-ambiguous)",
			desc = "Task Ambiguous",
			ft = { "norg" },
		},
		{
			"<LocalLeader>tc",
			"<Plug>(neorg.qol.todo-items.todo.task-cancelled)",
			desc = "Task Cancelled",
			ft = { "norg" },
		},
		{ "<LocalLeader>td", "<Plug>(neorg.qol.todo-items.todo.task-done)", desc = "Task Done", ft = { "norg" } },
		{
			"<LocalLeader>th",
			"<Plug>(neorg.qol.todo-items.todo.task-on-hold)",
			desc = "Task on Hold",
			ft = { "norg" },
		},
		{
			"<LocalLeader>ti",
			"<Plug>(neorg.qol.todo-items.todo.task-important)",
			desc = "Task Important",
			ft = { "norg" },
		},
		{
			"<LocalLeader>tp",
			"<Plug>(neorg.qol.todo-items.todo.task-pending)",
			desc = "Task Pending",
			ft = { "norg" },
		},
		{
			"<LocalLeader>tr",
			"<Plug>(neorg.qol.todo-items.todo.task-recurring)",
			desc = "Task Recurring",
			ft = { "norg" },
		},
		{ "<LocalLeader>tu", "<Plug>(neorg.qol.todo-items.todo.task-undone)", desc = "Task Undone", ft = { "norg" } },
		{ ">", "<Plug>(neorg.promo.promote.range)", desc = "Promote Range", ft = { "norg" } },
		{ "<", "<Plug>(neorg.promo.demote.range)", desc = "Demote Range", ft = { "norg" } },
	},
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
