return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			defaults = {
				mappings = {
					i = {
						["<C-j>"] = require("telescope.actions").move_selection_next,
						["<C-k>"] = require("telescope.actions").move_selection_previous,
					}
				}
			}
		},
		config = function(_, opts)
			local telescope = require("telescope")
			telescope.setup(opts)
			local builtin = require("telescope.builtin")
			local map = vim.keymap.set
			map("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
			map("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
			map("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
			map("n", "<leader>fh", builtin.help_tags, { desc = "Help" })
		end
	}
}
