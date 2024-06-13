return {
	"MysticalDevil/inlay-hints.nvim",
	event = "LspAttach",
	dependencies = { "neovim/nvim-lspconfig" },
	keys = {
		{ "<leader>oi", vim.cmd.InlayHintsToggle, desc = "Toggle InlayHints" },
	},
	opts = {
		commands = { enable = true }, -- Enable InlayHints commands, include `InlayHintsToggle`, `InlayHintsEnable` and `InlayHintsDisable`
		autocmd = { enable = true }, -- Enable the inlay hints on `LspAttach` event
	},
}
