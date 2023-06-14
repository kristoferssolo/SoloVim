local status_ok, _ = pcall(require, "mason-lspconfig")
if not status_ok then
	return
end

require("solo.mason.mason-installer")
require("solo.mason.handlers").setup()
require("solo.mason.null-ls")
