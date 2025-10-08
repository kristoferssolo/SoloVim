return {
	{
		"L3MON4D3/LuaSnip",
		build = "make install_jsregexp",
		version = "v2.*",
		dependencies = { "rafamadriz/friendly-snippets" },
		opts = function()
			local types = require("luasnip.util.types")
			return {
				history = true,
				updateevents = "TextChanged,TextChangedI",
				enable_autosnippets = true,
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

			require("luasnip.loaders.from_vscode").lazy_load()

			require("luasnip.loaders.from_lua").load({ paths = vim.fn.stdpath("config") .. "/snippets/" })

			ls.filetype_extend("c", { "cdoc" })
			ls.filetype_extend("cpp", { "cppdoc" })
			ls.filetype_extend("cs", { "csharpdoc" })
			ls.filetype_extend("html", { "djangohtml" })
			ls.filetype_extend("java", { "javadoc" })
			ls.filetype_extend("javascript", { "jsdoc" })
			ls.filetype_extend("kotlin", { "kdoc" })
			ls.filetype_extend("lua", { "luadoc" })
			ls.filetype_extend("php", { "phpdoc" })
			ls.filetype_extend("python", { "pydoc", "django" })
			ls.filetype_extend("ruby", { "rdoc" })
			-- ls.filetype_extend("rust", { "rustdoc" })
			ls.filetype_extend("sh", { "shelldoc" })
			ls.filetype_extend("typescript", { "tsdoc" })
		end,
	},
}
