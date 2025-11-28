return {
    {
        "Vigemus/iron.nvim",
        event = "VeryLazy",
        config = function()
            local iron = require("iron.core")
            iron.setup({
                repl_definition = {
                    python = { command = { "ipython" } },
                },
                preferred = { python = "ipython" },
                keymaps = { send_line = "<leader>rs" },
            })
            local map = vim.keymap.set
            map("v", "<leader>rr", function() iron.visual_send() end, { desc = "Send selection to REPL" })
            map("n", "<leader>rf", function() iron.send_file() end, { desc = "Send file to REPL" })
            map("n", "<leader>rc", function() iron.close_repl() end, { desc = "Close REPL" })
            map("n", "<leader>ro", function() iron.open_repl() end, { desc = "Open REPL" })
        end
    },
    {
        "hanschen/vim-ipython-cell",
        event = "VeryLazy",
    }
}
