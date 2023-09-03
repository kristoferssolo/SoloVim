if not pcall(require, "luasnip") then
	return
end

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("norg", {
	s(
		"meta",
		fmt(
			[[
				@document.meta
				title: {}
				author: {}
				categories: {}
				@end
				]],
			{
				i(1),
				c(2, {
					t("Kristofers Solo"),
					t("Kristiāns Francis Cagulis, kc22015"),
					t("Kristiāns Francis Cagulis"),
				}),
				i(0),
			}
		)
	),
})
