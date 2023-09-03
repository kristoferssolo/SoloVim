if not pcall(require, "luasnip") then
	return
end

local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local shared = require("solo.snips")
local same = shared.same

local cmake_version = function()
	local version = "3.27.4"
	-- vim.fn.jobstart("cmake --version | head -n 1 | rg -o '\\d+\\.\\d+\\.\\d+'", {})
	return version
end

ls.add_snippets("cmake", {
	s(
		"lib",
		fmt(
			[[
				cmake_minimum_required(VERSION {})
				project({})
				add_library(${{PROJECT_NAME}} src/{}.cc)
				]],
			{
				cmake_version(),
				i(1),
				same(1),
			}
		)
	),
	s(
		"bin",
		fmt(
			[[
				cmake_minimum_required(VERSION {})
				project({})
				add_executable(${{PROJECT_NAME}} src/main.cc)
				target_link_directories(${{PROJECT_NAME}} PRIVATE ${{CMAKE_SOURCE_DIR}}/include/{}/target/build/)
				target_link_libraries(${{PROJECT_NAME}} {})
			]],
			{
				cmake_version(),
				i(1),
				i(2),
				same(2),
			}
		)
	),
})
