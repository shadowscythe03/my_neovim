return {
	{
		"scottmckendry/cyberdream.nvim",
		priority = 1000,
		opts = {
			transparent = true,
			italic_comments = true,
		},
		config = function(_, opts)
			require("cyberdream").setup(opts)
			vim.cmd("colorscheme cyberdream")
		end
	},
	{ "nvim-lualine/lualine.nvim", opts = {} },
	{ "lewis6991/gitsigns.nvim", opts = {} },
	{ "nvim-tree/nvim-web-devicons" },
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
	{ "folke/trouble.nvim", opts = {} },
	{ "norcalli/nvim-colorizer.lua", config = function() require("colorizer").setup() end },
	{ "akinsho/bufferline.nvim", version = "*", dependencies = { "nvim-tree/nvim-web-devicons" }, opts = {} },
}
