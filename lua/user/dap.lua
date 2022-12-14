local status_mason_dap_ok, mason_dap = pcall(require, "mason-nvim-dap")
if not status_mason_dap_ok then
	return
end

local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
	return
end

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
	return
end

local dap_install_status_ok, dap_install = pcall(require, "dap-install")
if not dap_install_status_ok then
	return
end

mason_dap.setup({
	automatic_installation = true,
	automatic_setup = true,
})
dap_install.setup({})

dap_install.config("python", {})
-- add other configs here

dapui.setup({
	layouts = {
		{
			elements = {
				"scopes",
				"breakpoints",
				"stacs",
				"watches",
			},
			size = 40,
			position = "left",
		},
		{
			elements = {
				"repl",
				"console",
			},
			size = 10,
			position = "bottom",
		},
	},

	-- sidebar = {
	--     elements = {
	--         {
	--             id = "scopes",
	--             size = 0.25, -- Can be float or integer > 1
	--         },
	--         { id = "breakpoints", size = 0.25 },
	--     },
	--     size = 40,
	--     position = "right", -- Can be "left", "right", "top", "bottom"
	-- },
	-- tray = {
	--     elements = {},
	-- },
})

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
