local status_ok, _ = pcall(require, "mason-lspconfig")
if not status_ok then
    return
end

require("user.mason.mason-installer")
require("user.mason.handlers").setup()
require("user.mason.null-ls")
