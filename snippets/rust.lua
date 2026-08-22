---@diagnostic disable: undefined-global

local function cargo_tomls()
	local buffer_path = vim.api.nvim_buf_get_name(0)
	local start_path = buffer_path ~= "" and vim.fs.dirname(buffer_path) or vim.fn.getcwd()

	return vim.fs.find("Cargo.toml", { upward = true, path = start_path })
end

local bevy_cache = {}

local function has_bevy()
	if vim.fn.executable("rg") ~= 1 then
		return false
	end

	for _, cargo_toml in ipairs(cargo_tomls()) do
		local mtime = vim.uv.fs_stat(cargo_toml).mtime.sec
		local cached = bevy_cache[cargo_toml]

		if cached and cached.mtime == mtime then
			if cached.has_bevy then
				return true
			end
		else
			vim.fn.system({
				"rg",
				"--no-config",
				"--ignore-case",
				"--regexp",
				'^\\s*bevy\\s*=|package\\s*=\\s*"bevy"',
				cargo_toml,
			})

			local found = vim.v.shell_error == 0

			bevy_cache[cargo_toml] = {
				mtime = mtime,
				has_bevy = found,
			}

			if found then
				return true
			end
		end
	end

	return false
end

local function struct_tail()
	return c(2, {
		t(";"),

		sn(nil, {
			t("("),
			i(1),
			t(");"),
		}),

		sn(nil, {
			t({ " {", "\t" }),
			i(1),
			t({ "", "}" }),
		}),
	})
end

local function bevy_snippet(trigger, nodes)
	return s({
		trig = trigger,
		condition = has_bevy,
	}, nodes)
end

local base = {
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
		"ttest",
		fmta(
			[[
			#[tokio::test]
			async fn <name>() {
			    <body>
			}
		]],
			{
				name = i(1, "name"),
				body = i(0, "todo!();"),
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
local bevy = {
	bevy_snippet(
		"require",
		fmta(
			[[
			#[require(<component>)]
			]],
			{
				component = i(0, "Transform"),
			}
		)
	),
	bevy_snippet(
		"reflect",
		fmta(
			[[
			#[reflect(<param>)]
			]],
			{
				param = i(0, "Resource"),
			}
		)
	),
	bevy_snippet(
		"component",
		fmta(
			[[
			#[derive(Debug, Reflect, Component)]
			#[reflect(Component)]
			pub struct <name><tail>
		]],
			{
				name = i(1, "Component"),
				tail = struct_tail(),
			}
		)
	),
	bevy_snippet(
		"event",
		fmta(
			[[
			#[derive(Debug, Event)]
			pub struct <name><tail>
		]],
			{
				name = i(1, "Event"),
				tail = struct_tail(),
			}
		)
	),
	bevy_snippet(
		"resource",
		fmta(
			[[
			#[derive(Debug, Default, Reflect, Resource)]
			#[reflect(Resource)]
			pub struct <name><tail>
		]],
			{
				name = i(1, "Resource"),
				tail = struct_tail(),
			}
		)
	),
	bevy_snippet(
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
				body = i(0, "todo!();"),
			}
		)
	),
	bevy_snippet(
		"plugin",
		fmta(
			[[
			use bevy::prelude::*;

			pub(super) fn plugin(app: &mut App) {
				<body>
			}
		]],
			{
				body = i(0, "todo!();"),
			}
		)
	),
}

vim.list_extend(base, bevy)

return base
