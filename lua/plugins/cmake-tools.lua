return {
	"Civitasv/cmake-tools.nvim",
	ft = { "cpp", "c", "cmake" },
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		cmake_build_directory = "target/build/",
		cmake_executor = {
			default_opts = {
				quickfix = {
					show = "only_on_error",
					size = 15,
				},
			},
		},
	},
}
