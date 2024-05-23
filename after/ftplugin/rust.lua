local bufnr = vim.api.nvim_get_current_buf()
local opts = { silent = true, buffer = bufnr }
local nmap = require("solo.mappings").nmap

-- nmap("<leader>a", function()
-- 	vim.cmd.RustLsp("codeAction")
-- end)

nmap("<leader>re", vim.cmd.RustExpandMacro, "[E]xpand macro")
nmap("<leader>rc", vim.cmd.RustOpenCargo, "Open [C]argo.toml")
nmap("<leader>rp", vim.cmd.RustParentModule, "[P]arent module")
nmap("<leader>rh", vim.cmd.RustHoverActions, "[H]over actions")
nmap("<leader>rg", vim.cmd.RustViewCrateGraph, "View Create [G]raph")
nmap("<leader>rd", vim.cmd.RustOpenExternalDocs, "Open External [D]ocs")
nmap("<leader>rr", vim.cmd.RustRunnables, "Open [R]unnables")
nmap("<leader>ra", vim.cmd.RustCodeAction, "Code [A]ction Groups")
nmap("<leader>rD", vim.cmd.RustDebuggables, "[D]ebug")
nmap("<leader>drd", vim.cmd.RustDebuggables, "[D]ebug")
