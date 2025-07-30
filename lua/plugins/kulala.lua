return {
	"mistweaverco/kulala.nvim",
	keys = {
		{
			"<leader>kb",
			function()
				require("kulala").scratchpad()
			end,
			desc = "Open scratchpad",
		},
		{
			"<leader>ko",
			function()
				require("kulala").open()
			end,
			desc = "Open kulala",
		},
		{
			"<leader>kt",
			function()
				require("kulala").toggle_view()
			end,
			desc = "Toggle headers/body",
			ft = { "http", "rest" },
		},
		{
			"<leader>kS",
			function()
				require("kulala").show_stats()
			end,
			desc = "Show stats",
			ft = { "http", "rest" },
		},
		{
			"<leader>kq",
			function()
				require("kulala").close()
			end,
			desc = "Close window",
			ft = { "http", "rest" },
		},
		{
			"<leader>kc",
			function()
				require("kulala").copy()
			end,
			desc = "Copy as cURL",
			ft = { "http", "rest" },
		},
		{
			"<leader>kp",
			function()
				require("kulala").from_curl()
			end,
			desc = "Paste from cURL",
			ft = { "http", "rest" },
		},
		{
			"<leader>ks",
			function()
				require("kulala").run()
			end,
			desc = "Send request",
		},
		{
			"<cr>",
			function()
				require("kulala").run()
			end,
			desc = "Send request",
			ft = { "http", "rest" },
		},
		{
			"<leader>ka",
			function()
				require("kulala").run_all()
			end,
			desc = "Send all requests",
		},
		{
			"<leader>ki",
			function()
				require("kulala").inspect()
			end,
			desc = "Inspect current request",
			ft = { "http", "rest" },
		},
		{
			"<leader>kr",
			function()
				require("kulala").replay()
			end,
			desc = "Replay the last request",
		},
		{
			"<leader>kf",
			function()
				require("kulala").search()
			end,
			desc = "Find request",
			ft = { "http", "rest" },
		},
		{
			"<leader>kn",
			function()
				require("kulala").jump_next()
			end,
			desc = "Jump to next request",
			ft = { "http", "rest" },
		},
		{
			"<leader>kp",
			function()
				require("kulala").jump_prev()
			end,
			desc = "Jump to previous request",
			ft = { "http", "rest" },
		},
		{
			"<leader>ke",
			function()
				require("kulala").set_selected_env()
			end,
			desc = "Jump to previous request",
			ft = { "http", "rest" },
		},
		{
			"<leader>ku",
			function()
				require("lua.kulala.ui.auth_manager").open_auth_config()
			end,
			desc = "Manage Auth Config",
			ft = { "http", "rest" },
		},
		{
			"<leader>kg",
			function()
				require("kulala").download_graphql_schema()
			end,
			desc = "Download GraphQL schema",
			ft = { "http", "rest" },
		},
		{
			"<leader>kx",
			function()
				require("kulala").scripts_clear_global()
			end,
			desc = "Clear globals",
			ft = { "http", "rest" },
		},
		{
			"<leader>kX",
			function()
				require("kulala").clear_cached_files()
			end,
			desc = "Clear cached files",
			ft = { "http", "rest" },
		},
	},
	ft = { "http", "rest" },
	opts = {
		global_keymaps = false,
	},
}
