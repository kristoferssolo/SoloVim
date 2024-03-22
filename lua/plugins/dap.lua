return {
	"jayp0521/mason-nvim-dap.nvim",
	opts = {
		ensure_installed = {
			"python",
			"codelldb",
		},
		automatic_install = true,
	},
	dependencies = {
		"williamboman/mason.nvim",
		{ "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
		"mfussenegger/nvim-dap",
		{ "simrat39/rust-tools.nvim", ft = "rust" },
		{ "mfussenegger/nvim-dap-python", ft = "python" },
		"theHamsta/nvim-dap-virtual-text",
		"williamboman/mason.nvim",
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
			desc = "Test [M]ethod",
		},
		{
			"<leader>dpc",
			function()
				require("dap-python").test_class()
			end,
			desc = "Test [C]lass",
		},
		{
			"<leader>dps",
			function()
				require("dap-python").debug_selection()
			end,
			desc = "Debug [S]election",
		},
		{
			"<leader>dt",
			function()
				require("dapui").toggle()
			end,
			desc = "[T]oggle DAP-UI",
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
			desc = "Step [I]nto Code",
		},
		{
			"<leader>do",
			function()
				require("dap").step_over()
			end,
			desc = "Step [O]ver Code",
		},
		{
			"<leader>dO",
			function()
				require("dap").step_out()
			end,
			desc = "Step [O]ut of Code",
		},
		{
			"<leader>dT",
			function()
				require("dap").terminate()
			end,
			desc = "[T]erminate",
		},
		{
			"<leader>dl",
			function()
				require("dap").run_last()
			end,
			desc = "Run [L]ast",
		},
		{
			"<leader>dh",
			function()
				require("dap.ui.widgets").hover()
			end,
			desc = "[H]over",
		},
		{
			"<leader>dP",
			function()
				require("dap.ui.widgets").preview()
			end,
			desc = "[P]review",
		},
		{
			"<leader>df",
			function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.frames)
			end,
			desc = "[F]rames",
		},
		{
			"<leader>ds",
			function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.scopes)
			end,
			desc = "[S]copes",
		},
		{
			"<F5>",
			function()
				require("dap").continue()
			end,
			desc = "DAP Continue",
		},
		{
			"<F10>",
			function()
				require("dap").step_over()
			end,
			desc = "DAP Step Over",
		},
		{
			"<F11>",
			function()
				require("dap").step_into()
			end,
			desc = "DAP Step Into",
		},
		{
			"<F12>",
			function()
				require("dap").step_out()
			end,
			desc = "DAP Step Out",
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
		dap.adapters.gdb = {
			type = "executable",
			command = "gdb",
			args = { "-i", "dap" },
		}
		dap.configurations.cpp = {
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
		}
		dap.configurations.c = dap.configurations.cpp
	end,
}
