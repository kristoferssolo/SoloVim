return {
	"MeanderingProgrammer/py-requirements.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		enable_cmp = true,
		file_patterns = { "requirements.txt", "requirements_dev.txt", "requirements-dev.txt" },
		float_opts = { border = "rounded" },
		filter = {
			final_release = false,
			yanked = true,
		},
	},
}
