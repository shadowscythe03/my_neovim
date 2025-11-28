return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"mfussenegger/nvim-dap-python",
			"jay-babu/mason-nvim-dap.nvim",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup()
			require("mason-nvim-dap").setup({ ensure_installed = { "python" } })

			local python = vim.fn.exepath("python3") ~= "" and vim.fn.exepath("python3") or vim.fn.exepath("python")
			require("dap-python").setup(python)

			dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
			dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
			dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

			local map = vim.keymap.set
			map("n","<F5>", dap.continue, { desc = "DAP Continue" })
			map("n","<F10>", dap.step_over, { desc = "DAP Step Over" })
			map("n","<F11>", dap.step_into, { desc = "DAP Step Into" })
			map("n","<F12>", dap.step_out, { desc = "DAP Step Out" })
			map("n","<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
			map("n","<leader>dr", dap.repl.open, { desc = "Open REPL" })
			map("n","<leader>du", dapui.toggle, { desc = "Toggle DAP UI" })
		end
	}
}
