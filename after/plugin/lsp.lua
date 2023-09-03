if not pcall(require, "lsp-zero") then
	return
end

local lsp = require("lsp-zero").preset({
	float_border = "rounded",
	call_servers = "local",
	configure_diagnostics = true,
	setup_servers_on_start = true,
	set_lsp_keymaps = {
		preserve_mappings = false,
		omit = { "<F1>", "<F2>", "<F3>", "<F4>", "<F5>" },
	},
	manage_nvim_cmp = {
		set_sources = "recommended",
		set_basic_mappings = false,
		set_extra_mappings = false,
		use_luasnip = true,
		set_format = true,
		documentation_window = true,
	},
})

lsp.on_attach(function(_, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions

	-- lsp.default_keymaps({ buffer = bufnr })
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end
		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
	nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
	nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
	nmap("K", vim.lsp.buf.hover, "Hover Documentation")
	nmap("<C-K>", vim.lsp.buf.signature_help, "Signature Documentation")
	nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
end)

lsp.ensure_installed({
	"bashls",
	"clangd",
	"cmake",
	"cssls",
	"emmet_ls",
	"html",
	"jedi_language_server",
	"jsonls",
	"lua_ls",
	"sqlls",
	"tailwindcss",
	"taplo",
	"texlab",
	"tsserver",
})

lsp.configure("clangd", {
	capabilities = {
		offsetEncoding = { "utf-16" },
	},
	on_attach = function()
		require("clangd_extensions.inlay_hints").setup_autocmd()
		require("clangd_extensions.inlay_hints").set_inlay_hints()
	end,
})

lsp.configure("bashls", {
	filetypes = {
		"sh",
		"bash",
		"zsh",
	},
})

lsp.configure("emmet_ls", {
	filetypes = {
		"html",
		"htmldjango",
		"typescriptreact",
		"javascriptreact",
		"css",
		"sass",
		"scss",
		"less",
		"eruby",
	},
})

lsp.configure("texlab", {
	settings = {
		texlab = {
			auxDirectory = ".",
			bibtexFormatter = "texlab",
			build = {
				args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
				executable = "xelatex",
				forwardSearchAfter = false,
				onSave = false,
			},
			chktex = {
				onEdit = false,
				onOpenAndSave = false,
			},
			diagnosticsDelay = 0,
			formatterLineLength = 120,
			forwardSearch = {
				args = {},
			},
			latexFormatter = "latexindent",
			latexindent = {
				modifyLineBreaks = false,
			},
		},
	},
})

if not pcall(require, "neodev") then
	return
end
require("neodev").setup()
require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls({
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim", "awesome", "client" },
			},
			-- workspace = {
			-- Make the server aware of Neovim runtime files
			-- library = vim.api.nvim_get_runtime_file("", true),
			-- },
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
			root_pattern = {
				".stylua.toml",
				".luarc.json",
				".luarc.jsonc",
				".luacheckrc",
				"stylua.toml",
				"selene.toml",
				"selene.yml",
				".git",
			},
			format = {
				enable = false,
			},
		},
	},
}))

lsp.setup()

if not pcall(require, "null-ls") then
	return
end
local null_ls = require("null-ls")
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local formatting = null_ls.builtins.formatting
-- https://github.com/prettier-solidity/prettier-plugin-solidity
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	sources = {
		-- Here you can add tools not supported by mason.nvim
		-- make sure the source name is supported by null-ls
		-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md

		diagnostics.luacheck.with({ extra_args = { "--globals", "vim" } }),
		formatting.cbfmt.with({ extra_filetypes = { "vimwiki" } }),
		formatting.prettier.with({
			extra_filetypes = { "toml" },
			extra_args = {
				"--no-semi",
				"--double-quote",
				"--no-bracket-spacing",
				"--tab-width",
				"4",
				"--bracket-same-line",
				"--html-whitespace-sensitivity",
				"strict",
			},
		}),
		formatting.markdownlint.with({
			extra_filetypes = { "vimwiki" },
		}),
		formatting.markdown_toc.with({ extra_filetypes = { "vimwiki" } }),
		-- formatting.shellharden.with({ extra_filetypes = { "bash", "csh", "ksh", "zsh" } }),
		-- formatting.shfmt.with({ extra_filetypes = { "bash", "csh", "ksh", "zsh" } }),
	},
})

-- See mason-null-ls.nvim's documentation for more details:
-- https://github.com/jay-babu/mason-null-ls.nvim#setup
require("mason-null-ls").setup({
	ensure_installed = {
		"black",
		"cbfmt",
		"clang_format",
		"cmake_format",
		"cmake_lint",
		"cpplint",
		"djlint",
		"google_java_format",
		"luacheck",
		"markdown_toc",
		"mypy",
		"stylua",
		"usort",
		"yamlfmt",
		"rustywind",
		"letexindent",
	},
	automatic_installation = true,
	handlers = {
		-- Here you can add functions to register sources.
		-- See https://github.com/jay-babu/mason-null-ls.nvim#handlers-usage
		--
		-- If left empty, mason-null-ls will use a "default handler"
		-- to register all sources
	},
})

local cmp = require("cmp")
local cmp_action = require("lsp-zero").cmp_action()
local luasnip = require("luasnip")

local kind_icons = {
	Text = "󰉿",
	Method = "󰆧",
	Function = "󰊕",
	Constructor = "",
	Field = "󰜢",
	Variable = "󰀫",
	Class = "󰠱",
	Interface = "",
	Module = "",
	Property = "󰜢",
	Unit = "󰑭",
	Value = "󰎠",
	Enum = "",
	Keyword = "󰌋",
	Snippet = "",
	Color = "󰏘",
	File = "󰈙",
	Reference = "󰈇",
	Folder = "󰉋",
	EnumMember = "",
	Constant = "󰏿",
	Struct = "󰙅",
	Event = "",
	Operator = "󰆕",
	TypeParameter = "",
}

cmp.setup({
	mapping = {
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-u>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		-- Accept currently selected item. If none selected, `select` first item.
		-- Set `select` to `false` to only confirm explicitly selected items.
		["<cr>"] = cmp.mapping.confirm({ select = true }),
	},
	sources = {
		{ name = "gh_issues" },
		{ name = "nvim_lua" },
		{ name = "nvim_lsp" },
		{ name = "crates" },
		{ name = "path" },
		{ name = "luasnip" },
		{ name = "buffer" },
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	formatting = {
		fields = { "abbr", "kind", "menu" },
		format = function(entry, vim_item)
			vim_item.kind = kind_icons[vim_item.kind]
			vim_item.menu = ({
				nvim_lsp = "[LSP]",
				nvim_lua = "[api]",
				luasnip = "[snip]",
				buffer = "[buf]",
				path = "[path]",
				emoji = "[emoji]",
				gh_issues = "[issues]",
			})[entry.source.name]
			return vim_item
		end,
	},

	experimental = {
		ghost_text = true,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = false,
	},
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({}))
