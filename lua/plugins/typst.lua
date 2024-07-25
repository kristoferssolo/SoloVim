return {
	"chomosuke/typst-preview.nvim",
	ft = "typst",
	version = "*",
	build = function()
		require("typst-preview").update()
	end,
}
