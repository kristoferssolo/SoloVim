return {
	{
		"p00f/clangd_extensions.nvim",
		opts = {
			inlay_hints = {
				inline = vim.fn.has("nvim-0.10") == 1,
				-- Options other than `highlight' and `priority' only work
				-- if `inline' is disabled
				-- Only show inlay hints for the current line
				only_current_line = false,
				-- Event which triggers a refresh of the inlay hints.
				-- You can make this { "CursorMoved" } or { "CursorMoved,CursorMovedI" } but
				-- not that this may cause  higher CPU usage.
				-- This option is only respected when only_current_line and
				-- autoSetHints both are true.
				only_current_line_autocmd = { "CursorHold" },
				-- whether to show parameter hints with the inlay hints or not
				show_parameter_hints = true,
				-- prefix for parameter hints
				parameter_hints_prefix = "<- ",
				-- prefix for all the other hints (type, chaining)
				other_hints_prefix = "=> ",
				-- whether to align to the length of the longest line in the file
				max_len_align = true,
				-- padding from the left if max_len_align is true
				max_len_align_padding = 1,
				-- whether to align to the extreme right or not
				right_align = false,
				-- padding from the right if right_align is true
				right_align_padding = 8,
				-- The color of the hints
				highlight = "Comment",
				-- The highlight group priority for extmark
				priority = 100,
			},
			ast = {
				role_icons = {
					type = "",
					declaration = "",
					expression = "",
					specifier = "",
					statement = "",
					["template argument"] = "",
				},
				kind_icons = {
					Compound = "",
					Recovery = "",
					TranslationUnit = "",
					PackExpansion = "",
					TemplateTypeParm = "",
					TemplateTemplateParm = "",
					TemplateParamObject = "",
				},
				highlights = {
					detail = "Comment",
				},
			},

			memory_usage = {
				border = "none",
			},

			symbol_info = {
				border = "none",
			},
		},
	},
	{
		"Civitasv/cmake-tools.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		opts = {
			cmake_command = "cmake",
			cmake_build_directory = "target/build/",
			cmake_build_directory_prefix = "cmake_build_", -- when cmake_build_directory is "", this option will be activated
			cmake_generate_options = { "-D", "CMAKE_EXPORT_COMPILE_COMMANDS=1" },
			cmake_soft_link_compile_commands = true, -- if softlink compile commands json file
			cmake_build_options = {},
			cmake_console_size = 15, -- cmake output window height
			cmake_console_position = "belowright", -- "belowright", "aboveleft", ...
			cmake_show_console = "always", -- "always", "only_on_error"
			cmake_dap_configuration = { name = "cpp", type = "codelldb", request = "launch" }, -- dap configuration, optional
			cmake_variants_message = {
				short = { show = true },
				long = { show = true, max_length = 40 },
			},
		},
	},
}
