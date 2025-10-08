---@diagnostic disable: undefined-global

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

return {
	s(
		"lf",
		fmt(
			[[
			local function {}({})
				{}
			end
			]],
			{
				i(1),
				i(2),
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
}
