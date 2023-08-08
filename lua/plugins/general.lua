return {
	{ "folke/lazy.nvim" },
	{ "nvim-lua/plenary.nvim" }, -- Useful lua functions used by lots of plugins
	{
		"windwp/nvim-autopairs", -- Autopairs, integrates with both cmp and treesitter
		opts = {
			check_ts = true, -- treesitter integration
			disable_filetype = {
				"NvimTree",
				"TelescopePrompt",
				"alpha",
				"lazy",
			},
		},
	},

	{ "goolord/alpha-nvim", lazy = true },
	-- TODO: replace alphh with veil
	-- { "willothy/veil.nvim", lazy = true },

	{
		"andweeb/presence.nvim",
		opts = {
			auto_update = true, -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
			neovim_image_text = "The Only True Text Editor", -- Text displayed when hovered over the Neovim image
			main_image = "neovim", -- Main image display (either "neovim" or "file")
			-- client_id = "", -- Use your own Discord application client id (not recommended)
			log_level = nil, -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
			debounce_timeout = 10, -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
			enable_line_number = false, -- Displays the current line number instead of the current project
			blacklist = {}, -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
			buttons = true, -- Configure Rich Presence button(s), either a boolean to enable/disable, a static table (`{{ label = "<label>", url = "<url>" }, ...}`, or a function(buffer: string, repo_url: string|nil): table)
			file_assets = {}, -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)
			show_time = true, -- Show the timer

			-- Rich Presence text options
			editing_text = "Editing %s", -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
			file_explorer_text = "Browsing %s", -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
			git_commit_text = "Committing changes", -- Format string rendered when committing changes in git (either string or function(filename: string): string)
			plugin_manager_text = "Managing plugins", -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
			reading_text = "Reading %s", -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
			workspace_text = "Working on %s", -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
			line_number_text = "Line %s out of %s", -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
		},
	},

	{ "alvan/vim-closetag" },
	{ "tpope/vim-surround" },
	{ "mbbill/undotree", lazy = true },
	{ "preservim/tagbar" },
	{ "jghauser/mkdir.nvim", lazy = true },
	{ "mtdl9/vim-log-highlighting", lazy = true },
	{
		"edluffy/hologram.nvim",
		lazy = true,
		opts = {
			auto_display = true,
		},
	},

	{ "folke/which-key.nvim", lazy = true },

	{ "christoomey/vim-tmux-navigator" },
	{ "ThePrimeagen/vim-be-good", lazy = true },

	{ "rest-nvim/rest.nvim", lazy = true },

	{ "chipsenkbeil/distant.nvim", lazy = true },

	{
		"kevinhwang91/nvim-ufo",
		dependencies = {
			"kevinhwang91/promise-async",
		},
	},
}
