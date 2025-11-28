return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {
            ensure_installed = {
                "python","bash","json","lua","markdown","yaml","toml","query","regex","vim","vimdoc"
            },
            highlight = { enable = true },
            indent = { enable = true },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end
    }
}
