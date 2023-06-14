local status_ok, ls = pcall(require, "luasnip")
if not status_ok then
	return
end

require("luasnip/loaders/from_vscode").lazy_load()

local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet

vim.keymap.set({ "i", "s" }, "<C-j>", function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-k>", function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end, { silent = true })

vim.keymap.set({ "i" }, "<C-l>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end)

vim.keymap.set({ "i" }, "<C-h>", function()
	if ls.choice_active() then
		ls.change_choice(-1)
	end
end)

ls.config.set_config({
	-- This tells LuaSnip to remember to keep around the last snippet.
	-- You can jump back into it even if you move outside of the selection
	history = true,
	-- This one is cool cause if you have dynamic snippets, it updates as you type!
	updateevents = "TextChanged,TextChangedI",
	-- Autosnippets:
	enable_autosnippets = true,
	-- Crazy highlights!!
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = { { " « ", "NonTest" } },
			},
		},
	},
})

local get_year = function()
	return os.date("%Y")
end

local get_date = function()
	return os.date("%d.%m.%Y")
end

local same = function(index)
	return f(function(arg)
		return arg[1]
	end, { index })
end

ls.add_snippets(nil, {
	all = {},
	lua = {
		s(
			"status",
			fmt(
				[[
				local status_ok, {} = pcall(require, "{}")
				if not status_ok then
					return
				end
				]],
				{
					i(1),
					same(1),
				}
			)
		),
	},
	rust = {
		s(
			"modtest",
			fmt(
				[[
                #[cfg(test)]
                mod tests {{
                {}
                    {}
                }}
                ]],
				{
					c(1, { t("    use super::*;"), t("") }),
					i(0),
				}
			)
		),
	},
	python = {},
	cpp = {
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
					get_year(),
					i(1),
					get_date(),
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
		s(
			"templ",
			fmt(
				[[
				template <class {}>
				{}({}){{
					{}
				}}
				]],
				{
					c(1, { t("T"), t("T1, class T2") }),
					i(2),
					i(3),
					i(0),
				}
			)
		),
	},
	norg = {
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
					c(
						2,
						{
							t("Kristofers Solo"),
							t("Kristiāns Francis Cagulis, kc22015"),
							t("Kristiāns Francis Cagulis"),
						}
					),
					i(0),
				}
			)
		),
	},
})
