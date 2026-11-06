local function work()
	return dofile(vim.fn.expand("~/Obsidian/equilia/scripts/neovim.lua"))
end

return {
	"obsidian-nvim/obsidian.nvim",
	version = "*",
	cmd = { "Obsidian", "WorkTicket", "WorkStandup" },
	event = "BufReadPre " .. vim.fn.expand("~/Obsidian/") .. "**/*.md",
	dependencies = { "folke/snacks.nvim" },
	keys = {
		{ "<leader>Oo", "<cmd>Obsidian open<cr>", desc = "Open note in Obsidian" },
		{ "<leader>On", "<cmd>Obsidian new<cr>", desc = "New note" },
		{ "<leader>Of", "<cmd>Obsidian quick_switch<cr>", desc = "Find note" },
		{ "<leader>Os", "<cmd>Obsidian search<cr>", desc = "Search notes" },
		{ "<leader>Ob", "<cmd>Obsidian backlinks<cr>", desc = "Note backlinks" },
		{ "<leader>Ot", "<cmd>Obsidian tags<cr>", desc = "Note tags" },
		{ "<leader>OL", "<cmd>Obsidian links<cr>", desc = "Note links" },
		{ "<leader>Or", "<cmd>Obsidian rename<cr>", desc = "Rename note" },
		{ "<leader>OT", "<cmd>Obsidian toc<cr>", desc = "Note outline" },
		{ "<leader>Ow", "<cmd>Obsidian workspace<cr>", desc = "Switch vault" },
		{ "<leader>Od", "<cmd>Obsidian today<cr>", desc = "Today's standup" },
		{ "<leader>Og", "<cmd>WorkStandup<cr>", desc = "Generate today's standup draft" },
		{ "<leader>Oj", "<cmd>WorkTicket<cr>", desc = "Open or create Jira ticket" },
		{
			"<leader>Oc",
			function()
				work().task_state()
			end,
			desc = "Set ticket task state",
		},
		{
			"<leader>OP",
			function()
				work().link_pr()
			end,
			desc = "Link ticket PR",
		},
		{
			"<leader>OM",
			function()
				work().refresh_pr()
			end,
			desc = "Check PR status on GitHub",
		},
		{
			"<leader>OR",
			function()
				work().refresh_pr(true)
			end,
			desc = "Mark PR waiting for review",
		},
		{
			"<leader>Oi",
			function()
				work().open("Home.md")
			end,
			desc = "Work home",
		},
		{
			"<leader>Oa",
			function()
				work().open("Agenda.md")
			end,
			desc = "Work agenda",
		},
	},
	opts = {
		legacy_commands = false,
		workspaces = { { name = "equilia", path = "~/Obsidian/equilia" } },
		note_id_func = function(title)
			return title or os.date("%Y%m%d%H%M%S")
		end,
		notes_subdir = "notes",
		new_notes_location = "notes_subdir",
		picker = { name = "snacks.picker" },
		daily_notes = { folder = "standups", date_format = "YYYY-MM-DD", template = "Standup.md" },
		templates = { folder = "templates", date_format = "YYYY-MM-DD", time_format = "HH:mm" },
		frontmatter = { enabled = false },
		attachments = { folder = "assets/img" },
		ui = { enable = false },
	},
	config = function(_, opts)
		require("obsidian").setup(opts)
		vim.api.nvim_create_user_command("WorkTicket", function(args)
			work().ticket(args.args)
		end, { nargs = "?", desc = "Open or create an SEF ticket" })
		vim.api.nvim_create_user_command("WorkStandup", function()
			work().generate_standup()
		end, { desc = "Generate today's standup draft from ticket notes" })
	end,
}
