return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-neotest/nvim-nio", -- required runtime dependency
      "nvim-neotest/neotest-python",
      "antoinemadec/FixCursorHold.nvim",
    },
    config = function()
      local neotest = require("neotest")
      neotest.setup({
        adapters = {
          require("neotest-python")({
            dap = { justMyCode = false },
            runner = "pytest",
          })
        }
      })
      local map = vim.keymap.set
      map("n", "<leader>tt", function() neotest.run.run() end, { desc = "Run nearest test" })
      map("n", "<leader>tf", function() neotest.run.run(vim.fn.expand("%")) end, { desc = "Run file tests" })
      map("n", "<leader>to", function() neotest.output.open({ enter = true }) end, { desc = "Test output" })
      map("n", "<leader>ts", function() neotest.summary.toggle() end, { desc = "Toggle test summary" })
    end
  }
}
