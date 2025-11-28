-- init.lua

-- Leader key
vim.g.mapleader = " "

-- Bootstrap lazy.nvim
require("core.lazy")

-- Core settings and keymaps
require("core.options")
require("core.keymaps")

-- Plugins are loaded by lazy.nvim from the `lua/plugins` directory
