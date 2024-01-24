if not pcall(require, "luasnip") then
	return
end

local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local shared = require("solo.snips")
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
	s("pd", fmt([[println!("{}: {{:?}}", {});]], { same(1), i(1) })),
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
		"some",
		fmt(
			[[
		if let Some({}) = torrent.{}{{
			torrent_fields.push({}.to_string());
		}}
		]],
			{
				same(1),
				i(1),
				same(1),
			}
		)
	),
})
