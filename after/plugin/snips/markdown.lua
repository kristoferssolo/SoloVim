if not pcall(require, "luasnip") then
	return
end

local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets({ "markdown", "vimwiki" }, {
	s(
		"t",
		fmt("- [{}] {}", {
			c(2, { t(" "), t("-"), t("x") }),
			i(1, "task"),
		})
	),
})
