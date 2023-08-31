if not pcall(require, "dap") then
	return
end

local dap = require("dap")
local dapui = require("dapui")

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

local mason_registry = require("mason-registry")

vim.keymap.set("n", "<F5>", dap.continue)
vim.keymap.set("n", "<F10>", dap.step_over)
vim.keymap.set("n", "<F11>", dap.step_into)
vim.keymap.set("n", "<F12>", dap.step_out)

dapui.setup()
require("nvim-dap-virtual-text").setup({})

-- Python
local debugpy = mason_registry.get_package("debugpy")
local debugpy_path = debugpy:get_install_path() .. "/venv/bin/python"
require("dap-python").setup(debugpy_path)

local codelldb = mason_registry.get_package("codelldb")
local codelldb_path = codelldb:get_install_path() .. "/codelldb"
local liblldb_path = codelldb:get_install_path() .. "/extension/lldb/lib/liblldb.so"

-- Rust
require("rust-tools").setup({
	dap = {
		adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
	},
})

-- dap.configurations.rust = {}

-- C/C++
-- FIX: not working
dap.adapters.lldb = {
	type = "executable",
	command = codelldb_path,
	name = "lldb",
}
dap.configurations.cpp = {
	{
		name = "Launch",
		type = "lldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
		-- 💀
		-- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
		--
		--    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
		--
		-- Otherwise you might get the following error:
		--
		--    Error on launch: Failed to attach to the target process
		--
		-- But you should be aware of the implications:
		-- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
		-- runInTerminal = false,
	},
}

-- If you want to use this for Rust and C, add something like this:

dap.configurations.c = dap.configurations.cpp
