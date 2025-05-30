if not pcall(require, "luasnip") then
	return
end

local ls = require("luasnip")

local s = ls.snippet
local sn = ls.sn
local i = ls.insert_node
local t = ls.text_node
local d = ls.dynamic_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt

local shared = require("config.snips")

local newline = function(text)
	return t({ "", text })
end

local require_var = function(args, _)
	local text = args[1][1] or ""
	local split = vim.split(text, ".", { plain = true })

	local options = {}
	for len = 0, #split - 1 do
		table.insert(options, t(table.concat(vim.list_slice(split, #split - len, #split), "_")))
	end

	return sn(nil, {
		c(1, options),
	})
end

ls.add_snippets("lua", {
	s(
		"lf",
		fmt(
			[[
			local {} = function({})
				{}
			end{}
			]],
			{
				i(1),
				i(2),
				i(3),
				i(0),
			}
		)
	),
	s(
		"fn",
		fmt(
			[[
			function({})
				{}
			end
			]],
			{
				i(1),
				i(0),
			}
		)
	),
	s(
		"req",
		fmt([[ local {} = require("{}") ]], {
			d(2, require_var, { 1 }),
			i(1),
		})
	),
	s(
		"treq",
		fmt([[ local {} = require("telescope.{}") ]], {
			d(2, require_var, { 1 }),
			i(1),
		})
	),
})
