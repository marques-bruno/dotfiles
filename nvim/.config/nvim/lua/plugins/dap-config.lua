return {
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"nvim-neotest/nvim-nio",
		},
		config = function()
			-- Open / close dapui automagically when starting / stopping debugger
			local dap, dapui = require("dap"), require("dapui")
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			-- MAPPINGS:
			vim.keymap.set("n", "<leader>db", function()
				dap.set_breakpoint(vim.fn.input("Condition: "))
			end, { desc = " set breakpoint" })
			vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, { desc = " Toggle breakpoint" })
			vim.keymap.set("n", "<leader>dr", dap.run_to_cursor, { desc = "󰞒 Run to cursor" })
			vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "󰐎 Start/[C]ontinue" })
			vim.keymap.set("n", "<leader>dl", dap.step_into, { desc = " Step into" })
			vim.keymap.set("n", "<leader>dh", dap.step_out, { desc = " Step out" })
			vim.keymap.set("n", "<leader>dj", dap.step_over, { desc = "󰞔 Step over" })
			vim.keymap.set("n", "<leader>dk", dap.step_over, { desc = "󰞓 Step back" })
			vim.keymap.set("n", "<leader>dR", dap.restart, { desc = " Restart" })
			vim.keymap.set("n", "<leader>dT", function()
				dap.disconnect({ terminateDebuggee = true })
			end, { desc = " Stop debugging" })
			vim.keymap.set("n", "<leader>d<leader>", dapui.eval, { desc = " eval" })

			vim.keymap.set("n", "<leader>dsj", dap.down, { desc = "󰶡 Move down the stack" })
			vim.keymap.set("n", "<leader>dsk", dap.up, { desc = "󰶣 Move up the stack" })

			-- THEMEING / CUSTOMIZATION:
			-- A bit of customization: Nice catppuccin colors & better icons:
			vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#f38ba8" })
			vim.api.nvim_set_hl(0, "DapStopped", { fg = "#94e2d5" })
			vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint" })
			vim.fn.sign_define("DapStopped", { text = "󰜴", texthl = "DapStopped" })

			dapui.setup({
				floating = {
					border = "rounded", -- rounder borders for variable evaluation popups
				},
			})
		end,
	},
	{
		"mfussenegger/nvim-dap",
	},
	{
		"mfussenegger/nvim-dap-python",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"mfussenegger/nvim-dap",
		},
		ft = "python",
		config = function()
			-- DAP-PYTHON config
			local dap, dap_py = require("dap"), require("dap-python")
			-- DON'T FORGEt TO ADD debugpy to your interpreter through pip! FOR EVERY VENV you use:
			local venv = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_DEFAULT_ENV") or "/usr"
			-- local nvim_venv = '/home/test/.local/share/nvim/mason/packages/debugpy/venv/bin' .. '/python'
			-- dap_py.setup(nvim_venv)
			dap_py.setup(venv .. "/bin/python")
			dap_py.test_runner = "pytest"

			-- Add custom debug command to test methods with pytest
			vim.keymap.set("n", "<leader>dPt", function()
				dap_py.test_method()
			end, { desc = "[d]ebug [P]ython [t]est method" })

			-- FIX working directory for python debugger:
			dap.configurations.python = {
				{
					name = "Python: Launch file",
					type = "python",
					console = "integratedTerminal",
					request = "launch",
					program = "${file}",
					cwd = "${workspaceFolder}",
				},
				{
					name = "Python: Attach to proces",
					type = "python",
					request = "attach",
					processId = require('dap.utils').pick_process,
					cwd = "${workspaceFolder}",
				},
			}
		end,
	},
}
