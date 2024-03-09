return {
	"kristijanhusak/vim-dadbod-ui",
	dependencies = {
		{ "tpope/vim-dotenv" },
		{ "tpope/vim-dadbod" },
		{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" } },
	},
	cmd = {
		"DBUI",
		"DBUIToggle",
		"DBUIAddConnection",
		"DBUIFindBuffer",
	},
}
