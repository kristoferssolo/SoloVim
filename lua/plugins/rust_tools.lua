return {
	"simrat39/rust-tools.nvim",
	cond = false,
	dependencies = { "neovim/nvim-lspconfig" },
	ft = "rust",
	keys = {
		{ "<leader>re", vim.cmd.RustExpandMacro, desc = "[E]xpand macro" },
		{ "<leader>rc", vim.cmd.RustOpenCargo, desc = "Open [C]argo.toml" },
		{ "<leader>rp", vim.cmd.RustParentModule, desc = "[P]arent module" },
		{ "<leader>rh", vim.cmd.RustHoverActions, desc = "[H]over actions" },
		{ "<leader>rg", vim.cmd.RustViewCrateGraph, desc = "View Create [G]raph" },
		{ "<leader>rd", vim.cmd.RustOpenExternalDocs, desc = "Open External [D]ocs" },
		{ "<leader>rr", vim.cmd.RustRunnables, desc = "Open [R]unnables" },
		{ "<leader>ra", vim.cmd.RustCodeAction, desc = "Code [A]ction Groups" },
		{ "<leader>rD", vim.cmd.RustDebuggables, desc = "[D]ebug" },
		{ "<leader>drd", vim.cmd.RustDebuggables, desc = "[D]ebug" },
	},
	opts = {
		tools = {
			-- on_initialized = nil,
			on_initialized = function()
				vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave", "BufWritePost" }, {
					group = vim.api.nvim_create_augroup("InitializeRustAnalyzer", { clear = true }),
					pattern = { "*.rs" },
					callback = function()
						vim.lsp.codelens.refresh()
					end,
				})
			end,
			reload_workspace_from_cargo_toml = true,
			inlay_hints = {
				auto = true,
				only_current_line = false,
				show_parameter_hints = true,
				parameter_hints_prefix = " <- ",
				other_hints_prefix = " => ",
				max_len_align = false,
				max_len_align_padding = 1,
				right_align = false,
				right_align_padding = 7,
				highlight = "Comment",
			},
		},
	},
}
