return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = "kotlin",
      root = {
        "settings.gradle", -- Gradle (multi-project)
        "settings.gradle.kts", -- Gradle (multi-project)
        "build.xml", -- Ant
        "pom.xml", -- Maven
        "build.gradle", -- Gradle
        "build.gradle.kts", -- Gradle
      },
    })
  end,
  -- Add syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "kotlin" } },
  },
  -- Add language server
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        kotlin_lsp = {},
      },
    },
  },
  -- Add linting
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = { kotlin = { "ktlint" } },
    },
  },
  -- Add formatting
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = { kotlin = { "ktlint" } },
    },
  },
}
