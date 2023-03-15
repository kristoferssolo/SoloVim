return {
	on_attach = function(client, bufnr)
		require("sqls").on_attach(client, bufnr)
	end,
	filetypes = {
		"sql",
		"mysql",
	},
	settings = {
		sqls = {
			connections = {},
		},
	},
}
