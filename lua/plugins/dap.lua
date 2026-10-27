return {
	"mfussenegger/nvim-dap",
	ft = {
		"python",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"c",
		"cpp",
	},
	dependencies = {
		"jay-babu/mason-nvim-dap.nvim",
		{ "mason-org/mason.nvim", opts = {} },
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"mfussenegger/nvim-dap-python",
		"theHamsta/nvim-dap-virtual-text",
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
			desc = "Set conditional breakpoint",
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
				vim.api.nvim_feedkeys(vim.keycode("<Esc>"), "nx", false)
				require("dap-python").debug_selection()
			end,
			mode = "x",
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
			desc = "Start or continue debugging",
		},
		{
			"<leader>di",
			function()
				require("dap").step_into()
			end,
			desc = "Step into",
		},
		{
			"<leader>do",
			function()
				require("dap").step_over()
			end,
			desc = "Step over",
		},
		{
			"<leader>dO",
			function()
				require("dap").step_out()
			end,
			desc = "Step out",
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

		dapui.setup()
		require("mason-nvim-dap").setup({
			ensure_installed = {
				"codelldb",
				"js",
			},
		})

		require("nvim-dap-virtual-text").setup({})

		-- Python
		require("dap-python").setup("uv")
		require("dap-python").test_runner = "pytest"

		-- JavaScript / TypeScript
		local web_filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" }
		local mason_root = require("mason.settings").current.install_root_dir
		local is_windows = vim.fn.has("win32") == 1
		local node = "node"
		-- swapson's Mason node shim runs Bun, which cannot debug Node inspector sessions.
		for dir in vim.gsplit(vim.env.PATH or "", is_windows and ";" or ":", { plain = true, trimempty = true }) do
			if vim.fs.normalize(dir) ~= vim.fs.normalize(mason_root .. "/bin") then
				local candidate = dir .. (is_windows and "/node.exe" or "/node")
				if vim.fn.executable(candidate) == 1 then
					node = candidate
					break
				end
			end
		end

		local vscode = require("dap.ext.vscode")
		for _, adapter in ipairs({ "pwa-node", "pwa-chrome", "node", "chrome" }) do
			dap.adapters[adapter] = {
				type = "server",
				host = "127.0.0.1",
				port = "${port}",
				executable = {
					command = node,
					args = {
						mason_root .. "/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
						"${port}",
						"127.0.0.1",
					},
				},
				enrich_config = function(config, on_config)
					if config.type == "node" or config.type == "chrome" then
						config.type = "pwa-" .. config.type
					end
					if config.type == "pwa-node" and config.request == "launch" then
						if not config.runtimeExecutable or config.runtimeExecutable == "node" then
							config.runtimeExecutable = node
						end
					end
					on_config(config)
				end,
			}
			vscode.type_to_filetypes[adapter] = web_filetypes
		end

		for _, filetype in ipairs(web_filetypes) do
			local use_tsx = filetype ~= "javascript"
			dap.configurations[filetype] = {
				{
					name = use_tsx and "Launch file (tsx)" or "Launch file (Node.js)",
					type = "pwa-node",
					request = "launch",
					program = "${file}",
					cwd = "${workspaceFolder}",
					runtimeExecutable = node,
					runtimeArgs = use_tsx and { "--import", "tsx" } or {},
					console = "integratedTerminal",
					sourceMaps = true,
					skipFiles = { "<node_internals>/**" },
				},
				{
					name = "Attach to Node.js process",
					type = "pwa-node",
					request = "attach",
					processId = require("dap.utils").pick_process,
					cwd = "${workspaceFolder}",
					sourceMaps = true,
					skipFiles = { "<node_internals>/**" },
				},
				{
					name = "Launch Chrome",
					type = "pwa-chrome",
					request = "launch",
					url = function()
						return vim.fn.input("Dev server URL: ", "http://localhost:3000")
					end,
					webRoot = "${workspaceFolder}",
					sourceMaps = true,
				},
			}
		end

		-- C/C++
		local function executable_path()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end

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
				program = executable_path,
				cwd = "${workspaceFolder}",
				stopAtBeginningOfMainSubprogram = false,
			},
			{
				name = "Select and attach to process",
				type = "gdb",
				request = "attach",
				program = executable_path,
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
				program = executable_path,
				cwd = "${workspaceFolder}",
			},
		}
		dap.configurations.cpp = dap.configurations.c
	end,
}
