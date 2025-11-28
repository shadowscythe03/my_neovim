return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "b0o/SchemaStore.nvim",
      "stevearc/conform.nvim",
      "linux-cultist/venv-selector.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local on_attach = require("utils.on_attach").on_attach

      mason.setup()
      mason_lspconfig.setup({
        ensure_installed = {
          "pyright","ruff","bashls","jsonls","lua_ls","yamlls","marksman","dockerls","docker_compose_language_service","taplo"
        },
        automatic_installation = true,
      })

      require("mason-tool-installer").setup({
        ensure_installed = {
          "pyright","ruff","bash-language-server","json-lsp","lua-language-server","yaml-language-server","dockerfile-language-server","docker-compose-language-service","marksman","taplo",
          "black","isort","debugpy","ruff","stylua","jq","yamlfmt","mdformat","mypy",
        },
        auto_update = true,
        run_on_start = true,
      })

      -- Native vim.lsp.config setup (Neovim 0.11+)
      -- Define server configurations
      local servers = {
        lua_ls = {
          cmd = { "lua-language-server" },
          filetypes = { "lua" },
          root_markers = { ".luarc.json", ".luacheckrc", ".stylua.toml", "stylua.toml", ".git" },
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
            }
          }
        },
        jsonls = {
          cmd = { "vscode-json-language-server", "--stdio" },
          filetypes = { "json", "jsonc" },
          root_markers = { ".git" },
          settings = {
            json = {
              schemas = require("schemastore").json.schemas(),
              validate = { enable = true },
            }
          }
        },
        pyright = {
          cmd = { "pyright-langserver", "--stdio" },
          filetypes = { "python" },
          root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", ".git" },
          settings = {
            python = { analysis = { typeCheckingMode = "basic" } }
          }
        },
        ruff = {
          cmd = { "ruff", "server" },
          filetypes = { "python" },
          root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
        },
        bashls = {
          cmd = { "bash-language-server", "start" },
          filetypes = { "sh", "bash" },
          root_markers = { ".git" },
        },
        yamlls = {
          cmd = { "yaml-language-server", "--stdio" },
          filetypes = { "yaml", "yaml.docker-compose" },
          root_markers = { ".git" },
          settings = {
            yaml = { format = { enable = true } }
          }
        },
        marksman = {
          cmd = { "marksman", "server" },
          filetypes = { "markdown" },
          root_markers = { ".marksman.toml", ".git" },
        },
        dockerls = {
          cmd = { "docker-langserver", "--stdio" },
          filetypes = { "dockerfile" },
          root_markers = { "Dockerfile" },
        },
        docker_compose_language_service = {
          cmd = { "docker-compose-langserver", "--stdio" },
          filetypes = { "yaml.docker-compose" },
          root_markers = { "docker-compose.yaml", "docker-compose.yml", "compose.yaml", "compose.yml" },
        },
        taplo = {
          cmd = { "taplo", "lsp", "stdio" },
          filetypes = { "toml" },
          root_markers = { ".taplo.toml", "taplo.toml", ".git" },
        },
      }

      -- Register and enable each server
      for name, config in pairs(servers) do
        config.name = name
        config.capabilities = capabilities
        config.on_attach = on_attach
        
        -- Register the server config
        vim.lsp.config[name] = config
        
        -- Enable for appropriate filetypes
        vim.api.nvim_create_autocmd("FileType", {
          pattern = config.filetypes,
          callback = function(args)
            vim.lsp.enable(name, args.buf)
          end,
        })
      end

      require("conform").setup({
        formatters_by_ft = {
          python = { "ruff_fix", "ruff_format", "black", "isort" },
          lua = { "stylua" },
          json = { "jq" },
          yaml = { "yamlfmt" },
          markdown = { "mdformat" },
        },
        log_level = vim.log.levels.WARN,
        notify_on_error = true,
      })
      vim.keymap.set("n","<leader>cf", function() require("conform").format({ async = true }) end, { desc = "Format buffer" })

      require("venv-selector").setup({ name = {"venv",".venv"} })
      vim.keymap.set("n","<leader>cv", ":VenvSelect<CR>", { desc = "Select Python venv" })
    end
  }
}
