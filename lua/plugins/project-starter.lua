return {
	"KDesp73/project-starter.nvim",
	enabled = false,
	cmd = { "CreateProject" },
	config = function()
		local home_dir = os.getenv("HOME")
		require("project-starter").setup({
			default_paths = {
				-- c = "path/to/c/projects/",
				cpp = home_dir .. "/Templates/cpp",
				-- java = "path/to/java/projects/", -- this includes java swing projects
				-- nvim_plugins = "path/to/neovim/plugins",
				python = home_dir .. "/Templates/python/",
				-- ruby = "path/to/ruby/projects",
				-- android = "path/to/android/projects",
			},
			cd = true, -- change project directory after creation (default is true)
		})
	end,
}
