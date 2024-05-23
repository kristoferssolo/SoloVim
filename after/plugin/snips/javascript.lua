if not pcall(require, "luasnip") then
	return
end

local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets({ "javascript", "javascriptreact" }, {
	s(
		"jsd",
		fmt(
			[[
			/**
			* @param {{{}}} {}
			* @return {}
			*/
			]],
			{
				i(1),
				i(2),
				i(0),
			}
		)
	),
	s(
		"clog",
		fmt(
			[[
			console.log({})
			]],
			{
				i(0),
			}
		)
	),
})
