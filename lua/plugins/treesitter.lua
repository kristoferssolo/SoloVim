return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-context",
		"JoosepAlviste/nvim-ts-context-commentstring",
		"nvim-treesitter/nvim-treesitter-textobjects",
		"kristoferssolo/tree-sitter-bruno",
		{
			"bezhermoso/tree-sitter-ghostty",
			build = "make nvim_install",
		},
	},
	opts = {
		-- A list of parser names, or "all" (the five listed parsers should always be installed)
		ensure_installed = {
			"cpp",
			"lua",
			"rust",
			"python",
			"markdown",
			"json",
			"http",
			"markdown_inline",
			"sql",
		}, -- one of "all" or a list of languages
		-- Install parsers synchronously (only applied to `ensure_installed`)
		sync_install = false,
		-- Automatically install missing parsers when entering buffer
		-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
		auto_install = true,
		-- List of parsers to ignore installing (for "all")
		ignore_install = { "latex" },
		modules = {},

		highlight = {
			enable = true,
			-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
			-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
			-- Using this option may slow down your editor, and you may see some duplicate highlights.
			-- Instead of true it can also be a list of languages
			additional_vim_regex_highlighting = true,
		},
		indent = {
			enable = true,
		},
		fold = {
			enable = true,
		},
		incremenral_selection = {
			enable = false,
			keymaps = {
				init_selection = "<C-leader>",
				node_selection = "<C-space>",
				scope_selection = "<C-space>",
				node_deselection = "<C-backspace>",
			},
		},
		textobjects = {
			select = {
				enable = true,
				lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
				keymaps = {
					-- You can use the capture groups defined in textobjects.scm
					["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter" },
					["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter" },
					["af"] = { query = "@function.outer", desc = "Select outer part of a function" },
					["if"] = { query = "@function.inner", desc = "Select inner part of a function" },
					["ac"] = { query = "@class.outer", desc = "Select outer part of a class region" },
					["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
					["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },
					["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
					["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },
					["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
					["at"] = { query = "@comment.outer", desc = "Select outer part of a comment" },
					["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
				},
				-- You can choose the select mode (default is charwise 'v')
				--
				-- Can also be a function which gets passed a table with the keys
				-- * query_string: eg '@function.inner'
				-- * method: eg 'v' or 'o'
				-- and should return the mode ('v', 'V', or '<c-v>') or a table
				-- mapping query_strings to modes.
				selection_modes = {
					["@parameter.outer"] = "v", -- charwise
					["@function.outer"] = "V", -- linewise
					["@class.outer"] = "<C-v>", -- blockwise
				},
				-- If you set this to `true` (default is `false`) then any textobject is
				-- extended to include preceding or succeeding whitespace. Succeeding
				-- whitespace has priority in order to act similarly to eg the built-in
				-- `ap`.
				--
				-- Can also be a function which gets passed a table with the keys
				-- * query_string: eg '@function.inner'
				-- * selection_mode: eg 'v'
				-- and should return true of false
				include_surrounding_whitespace = true,
				move = {
					enable = true,
					set_jumps = true, -- whether to set jumps in the jumplist
					goto_next_start = {
						["]m"] = "@function.outer",
						["]]"] = "@class.outer",
					},
					goto_next_end = {
						["]M"] = "@function.outer",
						["]["] = "@class.outer",
					},
					goto_previous_start = {
						["[m"] = "@function.outer",
						["[["] = "@class.outer",
					},
					goto_previous_end = {
						["[M"] = "@function.outer",
						["[]"] = "@class.outer",
					},
					goto_next = {
						["]i"] = "@conditional.inner",
					},
					goto_previous = {
						["[i"] = "@conditional.inner",
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["]a"] = "@parameter.inner",
					},
					swap_previous = {
						["[a"] = "@parameter.inner",
					},
				},
			},
		},
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
		vim.cmd.highlight("TreesitterContext guibg=None")
		vim.cmd.highlight("TreesitterContextLineNumberBottom gui=underline guisp=Grey")
	end,
}
