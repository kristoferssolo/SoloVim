# SoloVim/

<a href="https://dotfyle.com/kristoferssolo/solovim"><img src="https://dotfyle.com/kristoferssolo/solovim/badges/plugins?style=flat" /></a>
<a href="https://dotfyle.com/kristoferssolo/solovim"><img src="https://dotfyle.com/kristoferssolo/solovim/badges/leaderkey?style=flat" /></a>
<a href="https://dotfyle.com/kristoferssolo/solovim"><img src="https://dotfyle.com/kristoferssolo/solovim/badges/plugin-manager?style=flat" /></a>

## Install Instructions

 > Install requires Neovim 0.9+. Always review the code before installing a configuration.

Clone the repository and install the plugins:

```sh
git clone git@github.com:kristoferssolo/SoloVim ~/.config/kristoferssolo/SoloVim
```

Open Neovim with this config:

```sh
NVIM_APPNAME=kristoferssolo/SoloVim/ nvim
```


## Obsidian

The maintained `obsidian-nvim/obsidian.nvim` plugin opens the Equilia vault at
`~/Obsidian/equilia`. Templates, ticket helpers, project data, and app setup live
inside that vault. See its `Workflow.md` for the work-note conventions.

- `Space Oi`: vault home.
- `Space Od`: today's standup.
- `Space Og`: generate today's standup draft from saved ticket notes.
- `Space Oj`: open or create an SEF ticket.
- `Space OP`: link a ticket PR.
- `Space OM`: check a linked PR on GitHub and record its status.
- `Space OR`: mark the linked PR waiting for review.
- `Space Oc`: set a ticket task's state.
- `Space Of` / `Space Os`: find / search notes.
- `Space Oa`: agenda source; `Space Oo` opens it in Obsidian to render queries.

## Plugins

### code-runner

+ [Civitasv/cmake-tools.nvim](https://dotfyle.com/plugins/Civitasv/cmake-tools.nvim)

### color

+ [uga-rosa/ccc.nvim](https://dotfyle.com/plugins/uga-rosa/ccc.nvim)
+ [xzbdmw/colorful-menu.nvim](https://dotfyle.com/plugins/xzbdmw/colorful-menu.nvim)
+ [catgoose/nvim-colorizer.lua](https://dotfyle.com/plugins/catgoose/nvim-colorizer.lua)

### colorscheme

+ [Mofiqul/dracula.nvim](https://dotfyle.com/plugins/Mofiqul/dracula.nvim)
+ [catppuccin/nvim](https://dotfyle.com/plugins/catppuccin/nvim)
+ [navarasu/onedark.nvim](https://dotfyle.com/plugins/navarasu/onedark.nvim)
+ [slugbyte/lackluster.nvim](https://dotfyle.com/plugins/slugbyte/lackluster.nvim)
+ [folke/tokyonight.nvim](https://dotfyle.com/plugins/folke/tokyonight.nvim)
+ [bluz71/vim-nightfly-colors](https://dotfyle.com/plugins/bluz71/vim-nightfly-colors)
+ [rose-pine/neovim](https://dotfyle.com/plugins/rose-pine/neovim)
+ [0xstepit/flow.nvim](https://dotfyle.com/plugins/0xstepit/flow.nvim)
+ [ellisonleao/gruvbox.nvim](https://dotfyle.com/plugins/ellisonleao/gruvbox.nvim)
+ [EdenEast/nightfox.nvim](https://dotfyle.com/plugins/EdenEast/nightfox.nvim)
+ [rebelot/kanagawa.nvim](https://dotfyle.com/plugins/rebelot/kanagawa.nvim)
+ [savq/melange-nvim](https://dotfyle.com/plugins/savq/melange-nvim)

### comment

+ [folke/todo-comments.nvim](https://dotfyle.com/plugins/folke/todo-comments.nvim)
+ [JoosepAlviste/nvim-ts-context-commentstring](https://dotfyle.com/plugins/JoosepAlviste/nvim-ts-context-commentstring)
+ [folke/ts-comments.nvim](https://dotfyle.com/plugins/folke/ts-comments.nvim)
+ [danymat/neogen](https://dotfyle.com/plugins/danymat/neogen)
+ [numToStr/Comment.nvim](https://dotfyle.com/plugins/numToStr/Comment.nvim)

### completion

+ [mikavilpas/blink-ripgrep.nvim](https://dotfyle.com/plugins/mikavilpas/blink-ripgrep.nvim)
+ [jdrupal-dev/css-vars.nvim](https://dotfyle.com/plugins/jdrupal-dev/css-vars.nvim)
+ [saghen/blink.cmp](https://dotfyle.com/plugins/saghen/blink.cmp)

### csv-files

+ [hat0uma/csvview.nvim](https://dotfyle.com/plugins/hat0uma/csvview.nvim)

### cursorline

+ [RRethy/vim-illuminate](https://dotfyle.com/plugins/RRethy/vim-illuminate)

### database

+ [kristijanhusak/vim-dadbod-ui](https://github.com/kristijanhusak/vim-dadbod-ui)

Use `<leader>od` to toggle Dadbod UI. Connections come from the project's private
`.env` through vim-dotenv. `DB_UI_LOCAL`, `DB_UI_STAGING_LV`, and
`DB_UI_PRODUCTION_LV` appear as `local`, `staging_lv`, and `production_lv`.
Percent-encode reserved characters in URL credentials, such as `#` as `%23`.

Saved queries live outside Git at
`~/.local/share/db_ui/<project>/<connection>/<query name>`. For example, an
incoming-api production query lives under
`~/.local/share/db_ui/incoming-api/production_lv/`. Each project has its own
saved-query folders even when connection names match. The project is the Git
root's directory name, or the current directory name outside a Git repository,
when Dadbod loads. Use a separate Neovim session for each project.

Expand a connection's `Saved queries` section to open existing SQL. Save a new
query with `<leader>W` in its SQL buffer. Saved connection URLs, if added through
Dadbod UI, go into that project's `connections.json`; project `.env` connections
do not need to be duplicated there.

### debugging

+ [mfussenegger/nvim-dap](https://dotfyle.com/plugins/mfussenegger/nvim-dap)
+ [theHamsta/nvim-dap-virtual-text](https://dotfyle.com/plugins/theHamsta/nvim-dap-virtual-text)
+ [rcarriga/nvim-dap-ui](https://dotfyle.com/plugins/rcarriga/nvim-dap-ui)

### dependency-management

+ [Saecki/crates.nvim](https://dotfyle.com/plugins/Saecki/crates.nvim)

### diagnostics

+ [folke/trouble.nvim](https://dotfyle.com/plugins/folke/trouble.nvim)

### editing-support

+ [HiPhish/rainbow-delimiters.nvim](https://dotfyle.com/plugins/HiPhish/rainbow-delimiters.nvim)
+ [folke/snacks.nvim](https://dotfyle.com/plugins/folke/snacks.nvim)
+ [nvim-treesitter/nvim-treesitter-context](https://dotfyle.com/plugins/nvim-treesitter/nvim-treesitter-context)
+ [windwp/nvim-ts-autotag](https://dotfyle.com/plugins/windwp/nvim-ts-autotag)

### file-explorer

+ [stevearc/oil.nvim](https://dotfyle.com/plugins/stevearc/oil.nvim)

### formatting

+ [stevearc/conform.nvim](https://dotfyle.com/plugins/stevearc/conform.nvim)

### game

+ [ThePrimeagen/vim-be-good](https://dotfyle.com/plugins/ThePrimeagen/vim-be-good)

### git

+ [NeogitOrg/neogit](https://dotfyle.com/plugins/NeogitOrg/neogit)

### github

+ [pwntester/octo.nvim](https://dotfyle.com/plugins/pwntester/octo.nvim)

### icon

+ [nvim-tree/nvim-web-devicons](https://dotfyle.com/plugins/nvim-tree/nvim-web-devicons)
+ [echasnovski/mini.icons](https://dotfyle.com/plugins/echasnovski/mini.icons)

### keybinding

+ [folke/which-key.nvim](https://dotfyle.com/plugins/folke/which-key.nvim)
+ [mawkler/demicolon.nvim](https://dotfyle.com/plugins/mawkler/demicolon.nvim)

### lsp

+ [mrcjkb/rustaceanvim](https://dotfyle.com/plugins/mrcjkb/rustaceanvim)
+ [mfussenegger/nvim-lint](https://dotfyle.com/plugins/mfussenegger/nvim-lint)
+ [linrongbin16/lsp-progress.nvim](https://dotfyle.com/plugins/linrongbin16/lsp-progress.nvim)
+ [neovim/nvim-lspconfig](https://dotfyle.com/plugins/neovim/nvim-lspconfig)
+ [stevearc/aerial.nvim](https://dotfyle.com/plugins/stevearc/aerial.nvim)

### markdown-and-latex

+ [tadmccorkle/markdown.nvim](https://dotfyle.com/plugins/tadmccorkle/markdown.nvim)
+ [OXY2DEV/markview.nvim](https://dotfyle.com/plugins/OXY2DEV/markview.nvim)

### marks

+ [ThePrimeagen/harpoon](https://dotfyle.com/plugins/ThePrimeagen/harpoon)

### media

+ [HakonHarnes/img-clip.nvim](https://dotfyle.com/plugins/HakonHarnes/img-clip.nvim)
+ [3rd/image.nvim](https://dotfyle.com/plugins/3rd/image.nvim)

### note-taking

+ [obsidian-nvim/obsidian.nvim](https://dotfyle.com/plugins/obsidian-nvim/obsidian.nvim)

### nvim-dev

+ [MunifTanjim/nui.nvim](https://dotfyle.com/plugins/MunifTanjim/nui.nvim)
+ [folke/lazydev.nvim](https://dotfyle.com/plugins/folke/lazydev.nvim)
+ [nvim-lua/plenary.nvim](https://dotfyle.com/plugins/nvim-lua/plenary.nvim)

### plugin-manager

+ [folke/lazy.nvim](https://dotfyle.com/plugins/folke/lazy.nvim)

### programming-languages-support

+ [dmmulroy/ts-error-translator.nvim](https://dotfyle.com/plugins/dmmulroy/ts-error-translator.nvim)
+ [jellydn/typecheck.nvim](https://dotfyle.com/plugins/jellydn/typecheck.nvim)
+ [chomosuke/typst-preview.nvim](https://dotfyle.com/plugins/chomosuke/typst-preview.nvim)

### session

+ [folke/persistence.nvim](https://dotfyle.com/plugins/folke/persistence.nvim)

### snippet

+ [rafamadriz/friendly-snippets](https://dotfyle.com/plugins/rafamadriz/friendly-snippets)
+ [L3MON4D3/LuaSnip](https://dotfyle.com/plugins/L3MON4D3/LuaSnip)

### statusline

+ [nvim-lualine/lualine.nvim](https://dotfyle.com/plugins/nvim-lualine/lualine.nvim)
+ [kristoferssolo/lualine-harpoon.nvim](https://dotfyle.com/plugins/kristoferssolo/lualine-harpoon.nvim)

### syntax

+ [nvim-treesitter/nvim-treesitter](https://dotfyle.com/plugins/nvim-treesitter/nvim-treesitter)
+ [nvim-treesitter/nvim-treesitter-textobjects](https://dotfyle.com/plugins/nvim-treesitter/nvim-treesitter-textobjects)

### test

+ [nvim-neotest/neotest](https://dotfyle.com/plugins/nvim-neotest/neotest)

### utility

+ [kiyoon/jupynium.nvim](https://dotfyle.com/plugins/kiyoon/jupynium.nvim)
+ [folke/noice.nvim](https://dotfyle.com/plugins/folke/noice.nvim)
+ [michaelrommel/nvim-silicon](https://dotfyle.com/plugins/michaelrommel/nvim-silicon)
+ [kevinhwang91/nvim-ufo](https://dotfyle.com/plugins/kevinhwang91/nvim-ufo)
+ [IogaMaster/neocord](https://dotfyle.com/plugins/IogaMaster/neocord)

### web-development

+ [mistweaverco/kulala.nvim](https://dotfyle.com/plugins/mistweaverco/kulala.nvim)

## Language Servers

+ astro
+ bashls
+ clangd
+ cmake
+ cssls
+ gopls
+ html
+ jsonls
+ lua_ls
+ neocmake
+ svelte
+ tailwindcss
+ taplo

 This readme was generated by [Dotfyle](https://dotfyle.com)
