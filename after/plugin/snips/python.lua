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
		"logger",
		fmt(
			[[
			import logging
			logger = logging.getLogger(__name__)
			]],
			{}
		)
	),
	s(
		"dbg",
		fmt(
			[[
			logger.debug({})
			]],
			{
				i(0),
			}
		)
	),
	s(
		"info",
		fmt(
			[[
			logger.info({})
			]],
			{
				i(0),
			}
		)
	),
	s(
		"warn",
		fmt(
			[[
			logger.warning({})
			]],
			{
				i(0),
			}
		)
	),
	s(
		"err",
		fmt(
			[[
			logger.error({})
			]],
			{
				i(0),
			}
		)
	),
	s(
		"exc",
		fmt(
			[[
			logger.exception({})
			]],
			{
				i(0),
			}
		)
	),
	s(
		"crit",
		fmt(
			[[
			logger.critical({})
			]],
			{
				i(0),
			}
		)
	),
	s(
		"fatal",
		fmt(
			[[
			logger.fatal({})
			]],
			{
				i(0),
			}
		)
	),
})
