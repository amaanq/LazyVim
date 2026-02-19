if lazyvim_docs then
  -- LSP Server to use for Python.
  -- Set to "basedpyright" to use basedpyright instead of pyright.
  vim.g.lazyvim_python_lsp = "pyright"
  -- Set to "ruff_lsp" to use the old LSP implementation version.
  vim.g.lazyvim_python_ruff = "ruff"
end

local lsp = vim.g.lazyvim_python_lsp or "pyright"
local ruff = vim.g.lazyvim_python_ruff or "ruff"

return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = "python",
      root = {
        "pyproject.toml",
        "setup.py",
        "setup.cfg",
        "requirements.txt",
        "Pipfile",
        "pyrightconfig.json",
      },
    })
  end,
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "ninja", "rst" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruff = {
          cmd_env = { RUFF_TRACE = "messages" },
          init_options = {
            settings = {
              logLevel = "error",
            },
          },
          keys = {
            {
              "<leader>co",
              LazyVim.lsp.action["source.organizeImports"],
              desc = "Organize Imports",
            },
          },
        },
        ruff_lsp = {
          keys = {
            {
              "<leader>co",
              LazyVim.lsp.action["source.organizeImports"],
              desc = "Organize Imports",
            },
          },
        },
      },
      setup = {
        [ruff] = function()
          Snacks.util.lsp.on({ name = ruff }, function(_, client)
            -- Disable hover in favor of Pyright
            client.server_capabilities.hoverProvider = false
          end)
        end,
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local servers = { "pyright", "basedpyright", "ruff", "ruff_lsp", ruff, lsp }
      for _, server in ipairs(servers) do
        opts.servers[server] = opts.servers[server] or {}
        opts.servers[server].enabled = server == lsp or server == ruff
      end
      -- basedpyright diagnostic overrides
      if lsp == "basedpyright" then
        opts.servers.basedpyright = vim.tbl_deep_extend("force", opts.servers.basedpyright, {
          settings = {
            basedpyright = {
              analysis = {
                diagnosticSeverityOverrides = {
                  reportMissingTypeStubs = "none",
                  reportUnusedImport = "information",
                  reportUnusedClass = "information",
                  reportUnusedFunction = "information",
                  reportOptionalMemberAccess = "none",
                  reportUnknownVariableType = "none",
                  reportUnusedCallResult = "none",
                  reportWildcardImportFromLibrary = "none",
                },
              },
              disableTaggedHints = true,
            },
          },
        })
      end
    end,
  },
}
