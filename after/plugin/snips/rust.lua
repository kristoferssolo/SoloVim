if not pcall(require, "luasnip") then
	return
end

local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local shared = require("config.snips")
local same = shared.same

ls.add_snippets("rust", {
	s(
		"modtest",
		fmt(
			[[
			#[cfg(test)]
			mod tests {{
				use super::*;
				{}
			}}
			]],
			{
				i(1),
			}
		)
	),
	s(
		"tmain",
		fmt(
			[[
			#[tokio::main]
			async fn main() -> Result<()> {{
				Ok(())
			}}
			]],
			{}
		)
	),
	s(
		"dead",
		fmt(
			[[
			#[allow(dead_code)]
			]],
			{}
		)
	),
	s(
		"component",
		fmt(
			[[
			#[derive(Debug, Reflect, Component)]
			#[reflect(Component)]
			struct {}
		]],
			{
				i(1),
			}
		)
	),
	s(
		"event",
		fmt(
			[[
			#[derive(Debug, Event)]
			struct {}
		]],
			{
				i(1),
			}
		)
	),
	s(
		"resource",
		fmt(
			[[
			#[derive(Debug, Default, Reflect, Resource)]
			#[reflect(Resource)]
			struct {}
		]],
			{
				i(1),
			}
		)
	),
	s(
		"schedule",
		fmt(
			[[
			#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash, ScheduleLabel)]
			struct {}
		]],
			{
				i(1),
			}
		)
	),
	s(
		"states",
		fmt(
			[[
			#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash, Default, States)]
			enum {} {{
				#[default]
				{}
			}}
		]],
			{
				i(1),
				i(2),
			}
		)
	),
	s(
		"systemset",
		fmt(
			[[
			#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash, SystemSet)]
			enum {} {{
				{}
			}}
		]],
			{
				i(1),
				i(2),
			}
		)
	),
	s(
		"plugin",
		fmt(
			[[
			use bevy::prelude::*;

			pub(super) fn plugin(app: &mut App) {{
				{}
			}}
		]],
			{
				i(1),
			}
		)
	),
})
