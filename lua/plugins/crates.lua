return {
	"Saecki/crates.nvim",
	tag = "stable",
	event = { "BufRead Cargo.toml" },
	keys = {
		{
			"<leader>ru",
			require("crates").upgrade_all_crates,
			desc = "Upgrade all crates",
			ft = { "rust", "toml" },
		},
	},
	opts = {
		completion = {
			cmp = {
				enabled = true,
			},
		},
		date_format = "%d-%m-%Y",
		thousands_separator = " ",
	},
}
