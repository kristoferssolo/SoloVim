local ft = {
	"csv",
	"tsv",
	"csv_semicolon",
	"csv_whitespace",
	"csv_pipe",
	"rfc_csv",
	"rfc_semicolon",
}
return {
	{
		"cameron-wags/rainbow_csv.nvim",
		ft = ft,
		cmd = {
			"RainbowDelim",
			"RainbowDelimSimple",
			"RainbowDelimQuoted",
			"RainbowMultiDelim",
		},
		opts = true,
	},
	{
		"hat0uma/csvview.nvim",
		ft = ft,
		cmd = {
			"CsvViewEnable",
			"CsvViewDisable",
			"CsvViewToggle",
		},
		config = function()
			require("csvview").setup()
		end,
	},
}
