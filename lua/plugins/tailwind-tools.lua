return {
	"luckasRanarison/tailwind-tools.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	enabled = false,
	ft = { "html", "htmldjango", "svelte", "astro", "vue", "javascriptreact", "typescriptreact", "php", "blade" },
	cmd = {
		"TailwindConcealEnable",
		"TailwindConcealDisable",
		"TailwindConcealToggle",
		"TailwindColorEnable",
		"TailwindColorDisable",
		"TailwindColorToggle",
		"TailwindSort",
		"TailwindSortSelection",
		"TailwindNextClass",
		"TailwindPrevClass",
	},
	opts = {
		document_color = {
			enabled = true, -- can be toggled by commands
			kind = "background", -- "inline" | "foreground" | "background"
			inline_symbol = "󰝤 ", -- only used in inline mode
			debounce = 200, -- in milliseconds, only applied in insert mode
		},
		conceal = {
			enabled = false, -- can be toggled by commands
			symbol = "󱏿", -- only a single character is allowed
			highlight = { -- extmark highlight options, see :h 'highlight'
				fg = "#38BDF8",
			},
		},
		custom_filetypes = {}, -- see the extension section to learn how it works
	},
}
