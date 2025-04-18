return {
	{
		"L3MON4D3/LuaSnip",
		build = "make install_jsregexp",
		version = "v2.*",
		dependencies = {
			"rafamadriz/friendly-snippets", -- a bunch of snippets to use
		},
		opts = function()
			local types = require("luasnip.util.types")
			return {
				-- This tells LuaSnip to remember to keep around the last snippet.
				-- You can jump back into it even if you move outside of the selection
				history = true,
				-- This one is cool cause if you have dynamic snippets, it updates as you type!
				updateevents = "TextChanged,TextChangedI",
				-- Autosnippets:
				enable_autosnippets = true,
				-- Crazy highlights!!
				ext_opts = {
					[types.choiceNode] = {
						active = {
							virt_text = { { " « ", "NonTest" } },
						},
					},
				},
			}
		end,
		config = function(_, opts)
			local ls = require("luasnip")

			local s = ls.snippet
			local sn = ls.snippet_node
			local isn = ls.indent_snippet_node
			local t = ls.text_node
			local i = ls.insert_node
			local f = ls.function_node
			local c = ls.choice_node
			local d = ls.dynamic_node
			local r = ls.restore_node
			local events = require("luasnip.util.events")
			local ai = require("luasnip.nodes.absolute_indexer")
			local extras = require("luasnip.extras")
			local l = extras.lambda
			local rep = extras.rep
			local p = extras.partial
			local m = extras.match
			local n = extras.nonempty
			local dl = extras.dynamic_lambda
			local fmt = require("luasnip.extras.fmt").fmt
			local fmta = require("luasnip.extras.fmt").fmta
			local conds = require("luasnip.extras.expand_conditions")
			local postfix = require("luasnip.extras.postfix").postfix
			local types = require("luasnip.util.types")
			local parse = require("luasnip.util.parser").parse_snippet
			local ms = ls.multi_snippet

			vim.keymap.set({ "i", "s" }, "<C-j>", function()
				if ls.expand_or_jumpable() then
					ls.expand_or_jump()
				end
			end, { silent = true })

			vim.keymap.set({ "i", "s" }, "<C-k>", function()
				if ls.jumpable(-1) then
					ls.jump(-1)
				end
			end, { silent = true })

			vim.keymap.set({ "i" }, "<C-l>", function()
				if ls.choice_active() then
					ls.change_choice(1)
				end
			end, { silent = true })

			vim.keymap.set({ "i" }, "<C-h>", function()
				if ls.choice_active() then
					ls.change_choice(-1)
				end
			end, { silent = true })

			ls.config.setup(opts)

			require("luasnip.loaders.from_vscode").load({
				exclude = {
					"rust",
					rust = {
						"modtest",
					},
				},
			})
			vim.tbl_map(function(type)
				require("luasnip.loaders.from_" .. type).lazy_load()
			end, { "vscode", "snipmate", "lua" })

			ls.filetype_extend("typescript", { "tsdoc" })
			ls.filetype_extend("javascript", { "jsdoc" })
			ls.filetype_extend("lua", { "luadoc" })
			ls.filetype_extend("python", { "pydoc" })
			ls.filetype_extend("rust", { "rustdoc" })
			ls.filetype_extend("cs", { "csharpdoc" })
			ls.filetype_extend("java", { "javadoc" })
			ls.filetype_extend("c", { "cdoc" })
			ls.filetype_extend("cpp", { "cppdoc" })
			ls.filetype_extend("php", { "phpdoc" })
			ls.filetype_extend("kotlin", { "kdoc" })
			ls.filetype_extend("ruby", { "rdoc" })
			ls.filetype_extend("sh", { "shelldoc" })
		end,
	},
}
