---@diagnostic disable: undefined-global

return {
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
}, { -- autosnippets
	s({ trig = "mt", name = "Math Block" }, fmta("$<>$", { i(1) })),
	s({ trig = "mmt", name = "Multiline Math Block" }, fmta("$ <> $", { i(1) })),
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
}
