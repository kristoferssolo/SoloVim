return {
	{
		"ahmedkhalf/project.nvim",
		dependenvies = {
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			local project = require("project_nvim")
			project.setup({
				-- detection_methods = { "lsp", "pattern" }, -- NOTE: lsp detection will get annoying with multiple langs in one project
				detection_methods = { "pattern" },
				-- patterns used to detect root dir, when **"pattern"** is in detection_methods
				patterns = { ".git", "package.json", ".venv", "Cargo.toml", "requirements.txt", "CMakeLists.txt" },
			})
			local telescope = require("telescope")
			telescope.load_extension("projects")
		end,
	},
}
