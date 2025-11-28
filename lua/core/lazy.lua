local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup(
  "plugins",
  {
    defaults = { lazy = false },
    install = { colorscheme = { "gruvbox" } },
    checker = { enabled = true },
    performance = {
      rtp = {
        disabled_plugins = {
          "gzip",
          "netrwPlugin",
          "tarPlugin",
          "tohtml",
          "tutor",
          "zipPlugin",
        }
      }
    }
  }
)
