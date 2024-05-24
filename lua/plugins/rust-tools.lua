return {
	"simrat39/rust-tools.nvim",
	dependencies = { "neovim/nvim-lspconfig" },
	ft = "rust",
	enabled = false,
	opts = {
		tools = {
			-- on_initialized = nil,
			on_initialized = function()
				vim.api.nvim_create_autocmd(
					{ "BufEnter", "CursorHold", "InsertLeave", "BufWritePost", "InsertEnter" },
					{
						group = vim.api.nvim_create_augroup("InitializeRustAnalyzer", { clear = true }),
						pattern = { "*.rs" },
						callback = function()
							vim.lsp.codelens.refresh()
						end,
					}
				)
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
