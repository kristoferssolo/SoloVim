return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	dependencies = {
		"echasnovski/mini.icons",
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
				{ "<leader>c", vim.cmd.bdelete, desc = "Close Buffer" },
				{
					"<leader>X",
					function()
						vim.cmd("!chmod +x %")
					end,
					desc = "Make Executable",
				},
				{ "<leader>x", group = "Trouble" },
				{ "<leader>g", group = "Git" },
				{ "<leader>q", group = "Persistence" },
				{ "<leader>l", group = "LSP" },
				{ "<leader>w", group = "Workspace" },
				{ "<leader>p", group = "Telescope", { "<leader>pd", group = "Development" } },
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
				--[[ {
					"<leader>P",
					group = "Templates",
					{
						{
							"<leader>Pl",
							group = "Latex",
							cond = function()
								return vim.bo.filetype == "lua"
							end,

							{
								"<leader>Plp",
								function()
									vim.cmd.read("~/Templates/LaTeX/PhilPaper.tex")
								end,
								desc = "PhilPaper.tex",
							},
							{
								"<leader>Pll",
								function()
									vim.cmd.read("~/Templates/LaTeX/Letter.tex")
								end,
								desc = "Letter.tex",
							},
							{
								"<leader>Plg",
								function()
									vim.cmd.read("~/Templates/LaTeX/Glossary.tex")
								end,
								desc = "Glossary.tex",
							},
							{
								"<leader>Plh",
								function()
									vim.cmd.read("~/Templates/LaTeX/HandOut.tex")
								end,
								desc = "HandOut.tex",
							},
							{
								"<leader>Plb",
								function()
									vim.cmd.read("~/Templates/LaTeX/PhilBeamer.tex")
								end,
								desc = "PhilBeamer.tex",
							},
							{
								"<leader>Pls",
								function()
									vim.cmd.read("~/Templates/LaTeX/SubFile.tex")
								end,
								desc = "SubFile.tex",
							},
							{
								"<leader>Plr",
								function()
									vim.cmd.read("~/Templates/LaTeX/Root.tex")
								end,
								desc = "Root.tex",
							},
							{
								"<leader>Plm",
								function()
									vim.cmd.read("~/Templates/LaTeX/MultipleAnswer.tex")
								end,
								desc = "MultipleAnswer.tex",
							},
						},
					},
				}, ]]
			},
		},
	},
}
