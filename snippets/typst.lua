---@diagnostic disable: undefined-global

return {
	s(
		{ trig = "([^%s]+)t", name = "Superscript", regTrig = true },
		fmta("(<>)^(<>)", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(0),
		})
	),
	s(
		{ trig = "([^%s]+)b", name = "Subscript", regTrig = true },
		fmta("(<>)_(<>)", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(0),
		})
	),
	s(
		{ trig = "([^%s]+)r", name = "Root", regTrig = true },
		fmta("sqrt(<>)", {
			f(function(_, snip)
				return snip.captures[1]
			end),
		})
	),
}, { -- autosnippets
	s({ trig = "mt", name = "Math Block" }, fmta("$<>$", { i(1) })),
	s({ trig = "mmt", name = "Multiline Math Block" }, fmta("$ <> $", { i(1) })),
}
