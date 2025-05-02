return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"jayp0521/mason-nvim-dap.nvim",
		"williamboman/mason.nvim",
		"rcarriga/nvim-dap-ui",
		"mfussenegger/nvim-dap",
		"nvim-neotest/nvim-nio",
		{ "mfussenegger/nvim-dap-python", ft = "python" },
		"theHamsta/nvim-dap-virtual-text",
		"neovim/nvim-lspconfig",
	},
	keys = {
		{
			"<leader>dd",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "Set breakpoint",
		},
		{
			"<leader>dD",
			function()
				require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end,
			desc = "Set Breakpoint with Condition",
		},
		{
			"<leader>dpm",
			function()
				require("dap-python").test_method()
			end,
			desc = "Test Method",
			ft = "python",
		},
		{
			"<leader>dpc",
			function()
				require("dap-python").test_class()
			end,
			desc = "Test Class",
			ft = "python",
		},
		{
			"<leader>dps",
			function()
				require("dap-python").debug_selection()
			end,
			desc = "Debug Selection",
			ft = "python",
		},
		{
			"<leader>dt",
			function()
				require("dapui").toggle()
			end,
			desc = "Toggle DAP-UI",
		},
		{
			"<leader>dc",
			function()
				require("dap").continue()
			end,
			desc = "Launch Debug Sessions and Resume Execution",
		},
		{
			"<leader>di",
			function()
				require("dap").step_into()
			end,
			desc = "Step Into Code",
		},
		{
			"<leader>do",
			function()
				require("dap").step_over()
			end,
			desc = "Step Over Code",
		},
		{
			"<leader>dO",
			function()
				require("dap").step_out()
			end,
			desc = "Step Out of Code",
		},
		{
			"<leader>dT",
			function()
				require("dap").terminate()
			end,
			desc = "Terminate",
		},
		{
			"<leader>dl",
			function()
				require("dap").run_last()
			end,
			desc = "Run Last",
		},
		{
			"<leader>dh",
			function()
				require("dap.ui.widgets").hover()
			end,
			desc = "Hover",
		},
		{
			"<leader>dP",
			function()
				require("dap.ui.widgets").preview()
			end,
			desc = "Preview",
		},
		{
			"<leader>df",
			function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.frames)
			end,
			desc = "Frames",
		},
		{
			"<leader>ds",
			function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.scopes)
			end,
			desc = "Scopes",
		},
		{
			"<F1>",
			function()
				require("dap").continue()
			end,
			desc = "DAP Continue",
		},
		{
			"<F2>",
			function()
				require("dap").step_into()
			end,
			desc = "DAP Step Into",
		},
		{
			"<F3>",
			function()
				require("dap").step_over()
			end,
			desc = "DAP Step Over",
		},
		{
			"<F4>",
			function()
				require("dap").step_out()
			end,
			desc = "DAP Step Out",
		},
		{
			"<F5>",
			function()
				require("dap").step_back()
			end,
			desc = "DAP Step Back",
		},
		{
			"<F6>",
			function()
				require("dap").restart()
			end,
			desc = "DAP Restart",
		},
	},
	config = function()
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

		dapui.setup()
		require("mason-nvim-dap").setup({
			automatic_installation = true,
			ensure_installed = {
				-- "firefox-debug-adapter",
				"codelldb",
			},
			automatic_install = true,
		})

		require("nvim-dap-virtual-text").setup({})

		--- Python
		require("dap-python").setup("python")

		--- JS/TS
		--[[ local firefox_debug_adapter = mason_registry.get_package("firefox-debug-adapter"):get_install_path()
			.. "/dist/adapter.bundle.js"
		dap.adapters.firefox = {
			type = "executable",
			command = "node",
			args = { firefox_debug_adapter },
		}
		dap.configurations.javascript = {
			{
				name = "Debug with Firefox",
				type = "firefox",
				request = "launch",
				reAttach = true,
				url = "http://localhost:3000",
				webRoot = "${workspaceFolder}",
				firefoxExecutable = "/usr/bin/floorp",
			},
		}
		dap.configurations.javascriptreact = dap.configurations.javascript
		dap.configurations.typescript = dap.configurations.javascript
		dap.configurations.typescriptreact = dap.configurations.javascript ]]

		-- C/C++
		dap.adapters.gdb = {
			type = "executable",
			command = "gdb",
			args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
		}
		dap.configurations.c = {
			{
				name = "Launch",
				type = "gdb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopAtBeginningOfMainSubprogram = false,
			},
			{
				name = "Select and attach to process",
				type = "gdb",
				request = "attach",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				pid = function()
					local name = vim.fn.input("Executable name (filter): ")
					return require("dap.utils").pick_process({ filter = name })
				end,
				cwd = "${workspaceFolder}",
			},
			{
				name = "Attach to gdbserver :1234",
				type = "gdb",
				request = "attach",
				target = "localhost:1234",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
			},
		}
		dap.configurations.cpp = dap.configurations.c
	end,
}
