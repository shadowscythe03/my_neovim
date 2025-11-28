local map = vim.keymap.set

-- General
map("n", "<leader>w", ":w<CR>", { desc = "Save file" })
map("n", "<leader>q", ":q<CR>", { desc = "Quit" })
map("n", "<leader>x", ":x<CR>", { desc = "Save & quit" })

