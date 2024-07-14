return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	dependencies = "nvim-tree/nvim-web-devicons",
	version = "*",
	opts = {
		preset = "modern",
		sort = { "alphanum", "local", "order", "group", "mod", "lower", "icase" },
		icons = {
			rules = false,
		},
		defaults = {},
		spec = {
			{
				mode = "v",
				"<leader>s",
				":s///gI<Left><Left><Left>",
				desc = "[s]ubstitute word",
			},
			{
				{ "<leader>C", vim.cmd.bdelete, desc = "[C]lose Buffer" },
				{ "<leader>c", group = "[C]url" },
				{ "<leader>t", group = "[T]rouble" },
				{ "<leader>g", group = "[G]it" },
				{ "<leader>q", group = "Persistence" },
				{ "<leader>l", group = "[L]SP" },
				{ "<leader>w", group = "[W]orkspace" },
				{ "<leader>p", group = "Telescope", { "<leader>pd", group = "[D]evelopment" } },
				{ "<leader>z", group = "[Z]en" },
				{ "<leader>o", group = "Action" },
				{ "<leader>r", group = "[R]ust" },
				{ "<leader>n", group = "Gitpat" },
				{ "<leader>m", group = "[M]isc" },
				{ "<leader>T", group = "Vim[T]ex" },
				{
					"<leader>d",
					group = "[D]AP",
					{
						"<leader>dp",
						group = "[P]ython",
					},
				},
				{
					"<leader>L",
					group = "[L]anguate settings",
					{ "<leader>Lc", "<cmd>setlocal formatoptions-=cro<cr>", desc = "Disable autocomment" },
					{ "<leader>LC", "<cmd>setlocal formatoptions=cro<cr>", desc = "Enable autocomment" },
					{ "<leader>Ls", "<cmd>setlocal spell!<cr>", desc = "Toggle spellchecker" },
					{ "<leader>Le", "<cmd>setlocal spell spelllang=en_us<cr>", desc = "Enable English spellchecker" },
					{ "<leader>Ll", "<cmd>setlocal spell spelllang=lv_LV<cr>", desc = "Enable Latvian spellchecker" },
					{ "<leader>LI", "<cmd>setlocal autoindent<cr>", desc = "Enable autoindent" },
					{ "<leader>Li", "<cmd>setlocal noautoindent<cr>", desc = "Disable autoindent" },
				},
				{
					"<leader>P",
					group = "Templates",
					{
						{
							"<leader>Pl",
							group = "[L]atex",
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
				},
			},
		},
	},
}
