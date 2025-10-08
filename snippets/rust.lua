---@diagnostic disable: undefined-global

local snippets = {
	s("p", fmta([[println!("{}", <>)]], { i(0) })),
	s(
		"modtest",
		fmta(
			[[
			#[cfg(test)]
			mod tests {
				use super::*;

				<>
			}
		]],
			{ i(0) }
		)
	),
	s(
		"test",
		fmta(
			[[
			#[test]
			fn <name>() {
				<body>
			}
		]],
			{
				name = i(1),
				body = i(0),
			}
		)
	),
	s(
		"rstest",
		fmta(
			[[
			#[rstest]
			#[case(<case>)]
			fn <name>(<args>) {
				<body>
			}
		]],
			{
				name = i(1),
				args = i(2),
				case = i(3),
				body = i(0),
			}
		)
	),
	s(
		"tmain",
		fmt(
			[[
			#[tokio::main]
			async fn main() -> Result<()> {{
				{}
			}}
			]],
			{
				i(1, "todo!();"),
			}
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
}

local function has_bevy()
	local cwd = vim.fn.getcwd()
	local cargo_toml = cwd .. "/Cargo.toml"

	if vim.fn.filereadable(cargo_toml) == 1 then
		local contents = vim.fn.readfile(cargo_toml)
		for _, line in ipairs(contents) do
			if line:match("^%s*bevy%s*=") or line:find("bevy") and not line:find("bevy%.") then
				return true
			end
		end
	end

	return false
end

local bevy_snippets = {
	s(
		"component",
		fmta(
			[[
			#[derive(Debug, Reflect, Component)]
			#[reflect(Component)]
			pub struct <name><params>
		]],
			{
				name = i(1, "Component"),
				params = c(2, {
					t(";"),
					t("(  );"),
					t(" {  }"),
				}),
			}
		)
	),
	s(
		"event",
		fmta(
			[[
			#[derive(Debug, Event)]
			pub struct <name><params>
		]],
			{
				name = i(1, "Event"),
				params = c(2, {
					t(";"),
					t("(  );"),
					t(" {  }"),
				}),
			}
		)
	),
	s(
		"resource",
		fmta(
			[[
			#[derive(Debug, Default, Reflect, Resource)]
			#[reflect(Resource)]
			pub struct <name><params>
		]],
			{
				name = i(1, "Resource"),
				params = c(2, {
					t(";"),
					t("(  );"),
					t(" {  }"),
				}),
			}
		)
	),
	s(
		"schedule",
		fmta(
			[[
			#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash, ScheduleLabel)]
			pub struct <name><params>
		]],
			{
				name = i(1, "Resource"),
				params = c(2, {
					t(";"),
					t("(  );"),
					t(" {  }"),
				}),
			}
		)
	),
	s(
		"state",
		fmta(
			[[
			#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash, Default, States)]
			pub enum <name> {
				#[default]
				<default>,
				<variants>
			}
		]],
			{
				name = i(1, "State"),
				default = i(2, "Default"),
				variants = i(0),
			}
		)
	),
	s(
		"systemset",
		fmta(
			[[
			#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash, SystemSet)]
			pub enum <name> {
				<body>
			}
		]],
			{
				name = i(1),
				body = i(2),
			}
		)
	),
	s(
		"plugin",
		fmta(
			[[
			use bevy::prelude::*;

			pub(super) fn plugin(app: &mut App) {
				<body>
			}
		]],
			{
				body = i(0),
			}
		)
	),
	s(
		"query",
		fmta(
			[[
			fn <name>(<args>) {
				<body>
			}
			]],
			{
				name = i(1, "system"),
				args = i(2, "args"),
				body = i(0),
			}
		)
	),
}

if has_bevy() then
	vim.tbl_extend("force", snippets, bevy_snippets)
end

return snippets
