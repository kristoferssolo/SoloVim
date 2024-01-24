return {
	"folke/which-key.nvim",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	config = function()
		local wk = require("which-key")
		wk.setup({
			window = {
				border = "single",
			},
		})

		local opts = {
			mode = "n", -- NORMAL mode
			prefix = "<leader>",
			buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
			silent = true, -- use `silent` when creating keymaps
			noremap = true, -- use `noremap` when creating keymaps
			nowait = true, -- use `nowait` when creating keymaps
		}
		local vopts = {
			mode = "v", -- VISUAL mode
			prefix = "<leader>",
			buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
			silent = true, -- use `silent` when creating keymaps
			noremap = true, -- use `noremap` when creating keymaps
			nowait = true, -- use `nowait` when creating keymaps
		}
		-- NOTE: Prefer using : over <cmd> as the latter avoids going back in normal-mode.
		-- see https://neovim.io/doc/user/map.html#:map-cmd
		local vmappings = {
			s = { ":s///gI<Left><Left><Left>", "[s]ubstitute word" },
		}

		local mappings = {
			c = { vim.cmd.bdelete, "[C]lose Buffer" },
			t = { name = "[T]rouble" },
			g = { name = "[G]it" },
			l = { name = "[L]SP" },
			p = {
				name = "Telescope",
				D = { name = "[D]evelopment" },
			},
			h = { name = "[H]arpoon" },
			z = { name = "[Z]en" },
			r = { name = "[R]ust" },
			w = { name = "Vim[W]iki" },
			L = {
				name = "[L]anguage settings",
				c = { "<cmd>setlocal formatoptions-=cro<cr>", "Disable autocomment" },
				C = { "<cmd>setlocal formatoptions=cro<cr>", "Enable autocomment" },
				s = { "<cmd>setlocal spell!<cr>", "Toggle spellchecker" },
				e = { "<cmd>setlocal spell spelllang=en_us<cr>", "Enable English spellchecker" },
				l = { "<cmd>setlocal spell spelllang=lv_LV<cr>", "Enable Lavian spellchecker" },
				I = { "<cmd>setlocal autoindent<cr>", "Enable autoindent" },
				i = { "<cmd>setlocal noautoindent<cr>", "Disable autoindent" },
			},
			d = {
				name = "[D]AP",
				p = { name = "[P]ython" },
				r = { name = "[R]ust" },
			},
			T = { name = "Vim[T]ex" },
			P = {
				name = "Tem[p]lates",
				l = {
					name = "[L]aTeX",
					p = {
						function()
							vim.cmd.read("~/Templates/LaTeX/PhilPaper.tex")
						end,
						"PhilPaper.tex",
					},
					l = {
						function()
							vim.cmd.read("~/Templates/LaTeX/Letter.tex")
						end,
						"Letter.tex",
					},
					g = {
						function()
							vim.cmd.read("~/Templates/LaTeX/Glossary.tex")
						end,
						"Glossary.tex",
					},
					h = {
						function()
							vim.cmd.read("~/Templates/LaTeX/HandOut.tex")
						end,
						"HandOut.tex",
					},
					b = {
						function()
							vim.cmd.read("~/Templates/LaTeX/PhilBeamer.tex")
						end,
						"PhilBeamer.tex",
					},
					s = {
						function()
							vim.cmd.read("~/Templates/LaTeX/SubFile.tex")
						end,
						"SubFile.tex",
					},
					r = {
						function()
							vim.cmd.read("~/Templates/LaTeX/Root.tex")
						end,
						"Root.tex",
					},
					m = {
						function()
							vim.cmd.read("~/Templates/LaTeX/MultipleAnswer.tex")
						end,
						"MultipleAnswer.tex",
					},
				},
			},
		}

		wk.register(mappings, opts)
		wk.register(vmappings, vopts)
	end,
}
