if not pcall(require, "luasnip") then
	return
end

local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local fmt = require("luasnip.extras.fmt").fmt
local c = ls.choice_node

ls.add_snippets("python", {
	s(
		"main",
		fmt(
			[[
			def main() -> None:
				{}


			if __name__ == "__main__":
				main()
			]],
			{
				i(1, "pass"),
			}
		)
	),
})
