return {
	"epwalsh/obsidian.nvim",
	version = "*",
	lazy = true,
	event = "BufReadPre " .. vim.fn.expand("~") .. "/Obsidian/**/*.md",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	keys = {
		{ "<leader>Oo", vim.cmd.ObsidianOpen, desc = "Open a note in the Obsidian app." },
		{ "<leader>On", vim.cmd.ObsidianNew, desc = "Create a new note." },
		{ "<leader>Of", vim.cmd.ObsidianQuickSwitch, desc = "Quickly switch to (or open) another note in vault." },
		{ "<leader>Ob", vim.cmd.ObsidianBacklinks, desc = "Get a picker list of references to the current buffer." },
		{ "<leader>Ot", vim.cmd.ObsidianTags, desc = "Get a picker list of all occurrences of the given tags." },
		{ "<leader>Os", vim.cmd.ObsidianSearch, desc = "Search for (or create) notes in your vault." },
		{
			"<leader>Ol",
			vim.cmd.ObsidianLinkNew,
			desc = "Create a new note and link it to an inline visual selection of text.",
		},
		{
			"<leader>OL",
			vim.cmd.ObsidianLinks,
			desc = "Collect all links within the current buffer into a picker window.",
		},
		{
			"<leader>OE",
			vim.cmd.ObsidianExtractNote,
			desc = "Extract the visually selected text into a new note and link to it.",
		},
		{ "<leader>Ow", vim.cmd.ObsidianWorkspace, desc = "Switch to another workspace." },
		-- { "<leader>Op", vim.cmd.ObsidianPasteImg, desc = "Paste an image from the clipboard into the note." },
		{
			"<leader>Or",
			vim.cmd.ObsidianRename,
			desc = "Rename the note of the current buffer or reference under the cursor, updating all backlinks across the vault.",
		},
		{
			"<leader>OT",
			vim.cmd.ObsidianRename,
			desc = "Load the table of contents of the current note into a picker list.",
		},
	},
	opts = {
		workspaces = {
			{
				name = "university",
				path = "~/Obsidian/university",
			},
			{
				name = "personal",
				path = "~/Obsidian/personal",
			},
			{
				name = "work",
				path = "~/Obsidian/work",
			},
		},
		mappings = {
			-- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
			["gf"] = {
				action = function()
					return require("obsidian").util.gf_passthrough()
				end,
				opts = { noremap = false, expr = true, buffer = true },
			},
			-- Toggle check-boxes.
			["<leader>ch"] = {
				action = function()
					return require("obsidian").util.smart_action()
				end,
				opts = { buffer = true, expr = true },
			},
			-- Smart action depending on context, either follow link or toggle checkbox.
			["<cr>"] = nil,
		},

		-- Optional, customize how note IDs are generated given an optional title.
		---@param title string|?
		---@return string
		note_id_func = function(title)
			-- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
			-- In this case a note with the title 'My new note' will be given an ID that looks
			-- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
			local suffix = ""
			if title ~= nil then
				-- If title is given, transform it into valid file name.
				suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
			else
				-- If title is nil, just add 4 random uppercase letters to the suffix.
				for _ = 1, 4 do
					suffix = suffix .. string.char(math.random(65, 90))
				end
			end
			return tostring(os.time()) .. "-" .. suffix
		end,
		-- Optional, customize how wiki links are formatted. You can set this to one of:
		--  * "use_alias_only", e.g. '[[Foo Bar]]'
		--  * "prepend_note_id", e.g. '[[foo-bar|Foo Bar]]'
		--  * "prepend_note_path", e.g. '[[foo-bar.md|Foo Bar]]'
		--  * "use_path_only", e.g. '[[foo-bar.md]]'
		-- Or you can set it to a function that takes a table of options and returns a string, like this:
		wiki_link_func = function(opts)
			return require("obsidian.util").wiki_link_id_prefix(opts)
		end,
		templates = {
			folder = "templates",
			date_format = "%Y-%m-%d",
			time_format = "%H:%M:%S",
		},
		attachments = {
			-- The default folder to place images in via `:ObsidianPasteImg`.
			-- If this is a relative path it will be interpreted as relative to the vault root.
			-- You can always override this per image by passing a full path to the command instead of just a filename.
			img_folder = "assets/img",

			-- Optional, customize the default name or prefix when pasting images via `:ObsidianPasteImg`.
			---@return string
			img_name_func = function()
				print(os.time())
				return string.format("%s-", os.time())
			end,

			-- A function that determines the text to insert in the note when pasting an image.
			-- It takes two arguments, the `obsidian.Client` and an `obsidian.Path` to the image file.
			-- This is the default implementation.
			---@param client obsidian.Client
			---@param path obsidian.Path the absolute path to the image file
			---@return string
			img_text_func = function(client, path)
				path = client:vault_relative_path(path) or path
				return string.format("![%s](../%s)", path.name, path)
			end,
		},
		ui = {
			enable = false,
		},
	},
}
