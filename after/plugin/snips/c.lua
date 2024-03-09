if not pcall(require, "luasnip") then
	return
end

local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

local shared = require("solo.snips")
local same = shared.same
local year = shared.year
local date = shared.date

ls.add_snippets("c", {
	s(
		"auth",
		fmt(
			[[
		              // Copyright {}
		              // Author - Kristiāns Francis Cagulis, kc22015
		              // {}
		              // Created: {}
		              ]],
			{
				year(),
				i(1),
				date(),
			}
		)
	),
	s(
		"fn",
		fmt(
			[[
                // {};
                // Funkcija {}({}) -
                // {}
                {} {{
                }}
                ]],
			{
				same(1),
				f(function(function_name)
					if not function_name[1][1] then
						function_name[1][1] = ""
					end
					local words = {}
					for word in function_name[1][1]:gmatch("%w+") do
						table.insert(words, word)
					end
					return words[2] or ""
				end, { 1 }),
				i(2),
				i(0),
				i(1),
			}
		)
	),
})
