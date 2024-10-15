return {
	"MeanderingProgrammer/py-requirements.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter" },

	opts = {
		-- Enabled by default if you do not use `nvim-cmp` set to false
		enable_cmp = false,
		-- Endpoint used for getting package versions
		index_url = "https://pypi.org/simple/",
		-- Fallback endpoint in case 'index_url' fails to find a package
		extra_index_url = nil,
		-- Specify which file patterns plugin is active on
		-- For info on patterns, see :h pattern
		file_patterns = {
			"requirements.txt",
			"requirements.lock",
			"requirements-dev.txt",
			"requirements-dev.lock",
			"requirements_dev.txt",
		},
		-- For available options, see :h vim.lsp.util.open_floating_preview
		float_opts = { border = "rounded" },
		filter = {
			-- If set to true pull only final release versions, this will ignore alpha,
			-- beta, release candidate, post release, and developmental release versions
			final_release = false,
			-- If set to true (default value) filter out yanked package versions
			yanked = true,
		},
		-- Query to get each module present in a file
		requirement_query = "(requirement) @requirement",
		-- Query to get information out of each module
		module_query = [[
        (requirement (package) @name)
        (version_spec (version_cmp) @cmp)
        (version_spec (version) @version)
    ]],
	},
	config = function(_, opts)
		require("py-requirements").setup(opts)
	end,
}
