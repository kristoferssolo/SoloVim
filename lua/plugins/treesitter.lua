return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/playground",
			"p00f/nvim-ts-rainbow",
			"mechatroner/rainbow_csv",
			"nvim-treesitter/nvim-treesitter-textobjects",
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		config = function()
			require("nvim-treesitter.configs").setup({

				-- A list of parser names, or "all" (the five listed parsers should always be installed)
				ensure_installed = "all", -- one of "all" or a list of languages
				-- Install parsers synchronously (only applied to `ensure_installed`)
				sync_install = true,
				-- Automatically install missing parsers when entering buffer
				-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
				auto_install = true,
				-- List of parsers to ignore installing (for "all")
				-- ignore_install = { "" },

				highlight = {
					enable = true,
					disable = {},
					-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
					-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
					-- Using this option may slow down your editor, and you may see some duplicate highlights.
					-- Instead of true it can also be a list of languages
					additional_vim_regex_highlighting = false,
				},
				autopairs = {
					enable = true,
				},
				autotag = {
					enable = true,
					filetypes = {
						"html",
						"htmldjango",
						"javascript",
						"typescript",
						"javascriptreact",
						"typescriptreact",
						"svelte",
						"vue",
						"tsx",
						"jsx",
						"rescript",
						"xml",
						"php",
						"markdown",
						"glimmer",
						"handlebars",
						"hbs",
					},
				},
				indent = { enable = true, disable = { "" } },
				rainbow = {
					enable = true,
					-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
					extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
					max_file_lines = nil, -- Do not enable for files with more than n lines, int
					-- colors = {}, -- table of hex strings
					-- termcolors = {}, -- table of colour name strings
				},
			})
		end,
	},
}
