return {
	"kristoferssolo/jsonl.nvim",
	ft = { "ndjson", "jsonl", "jsonlines" },
	opts = {
		json_formatter = function(bufnr)
			require("conform").format({ bufnr = bufnr, async = false })
		end,
	},
}
