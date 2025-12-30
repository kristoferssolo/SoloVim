return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	dependencies = {
		{ "echasnovski/mini.icons", version = "*" },
	},
	version = "v3",
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
	opts = {
		preset = "modern",
		sort = { "alphanum", "local", "order", "group", "mod", "lower", "icase" },
		icons = {},
		defaults = {},
		disable = {
			ft = {},
			bt = { "NeogitPopup" },
		},
		spec = {
			{
				mode = "v",
				"<leader>s",
				":s///gI<Left><Left><Left><Left>",
				desc = "substitute word",
			},
			{
				{
					"<leader>X",
					function()
						vim.cmd("!chmod +x %")
					end,
					desc = "Make Executable",
				},
				{ "<leader>x", group = "Trouble" },
				{ "<leader>g", group = "Git" },
				{ "<leader>go", group = "Octo" },
				{ "<leader>q", group = "Persistence" },
				{ "<leader>l", group = "LSP" },
				{ "<leader>w", group = "Workspace" },
				{ "<leader>p", group = "Picker" },
				{ "<leader>z", group = "Zen" },
				{ "<leader>o", group = "Action" },
				{ "<leader>r", group = "Rust" },
				{ "<leader>n", group = "Gitpat" },
				{ "<leader>m", group = "Misc" },
				{ "<leader>T", group = "VimTex" },
				{ "<leader>N", group = "Notifications" },
				{ "<leader>O", group = "Obsidian" },
				{ "<leader>s", group = "Neogen" },
				{ "<leader>t", group = "Neotest" },
				{ "<leader>k", group = "Kulala" },
				{
					"<leader>d",
					group = "DAP",
					{
						"<leader>dp",
						group = "Python",
					},
				},
				{
					"<leader>L",
					group = "Languate settings",
					{ "<leader>Lc", "<cmd>setlocal formatoptions-=cro<cr>", desc = "Disable autocomment" },
					{ "<leader>LC", "<cmd>setlocal formatoptions=cro<cr>", desc = "Enable autocomment" },
					{ "<leader>Ls", "<cmd>setlocal spell!<cr>", desc = "Toggle spellchecker" },
					{ "<leader>Le", "<cmd>setlocal spell spelllang=en_us<cr>", desc = "Enable English spellchecker" },
					{ "<leader>Ll", "<cmd>setlocal spell spelllang=lv_LV<cr>", desc = "Enable Latvian spellchecker" },
					{ "<leader>LI", "<cmd>setlocal autoindent<cr>", desc = "Enable autoindent" },
					{ "<leader>Li", "<cmd>setlocal noautoindent<cr>", desc = "Disable autoindent" },
				},
			},
		},
	},
}
