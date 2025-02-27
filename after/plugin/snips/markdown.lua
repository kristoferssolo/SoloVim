if not pcall(require, "luasnip") then
	return
end

local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("markdown", {
	s(
		"ket",
		fmt(
			[[
			|{}angle.r{}
			]],
			{
				i(1),
				i(0),
			}
		)
	),
	s(
		"ket0",
		fmt(
			[[
			|0angle.r
			]],
			{}
		)
	),
	s(
		"ket1",
		fmt(
			[[
			|1angle.r
			]],
			{}
		)
	),
	s(
		"ketp",
		fmt(
			[[
			|Psi angle.r
			]],
			{}
		)
	),
})
