return {
  {
    "snacks.nvim",
    keys = {
      {
        "<leader>jj",
        function()
          Snacks.terminal("jjui", { cwd = LazyVim.root.git(), win = { border = "rounded" } })
        end,
        desc = "Jujutsu UI (Root Dir)",
      },
      {
        "<leader>jJ",
        function()
          Snacks.terminal("jjui", { win = { border = "rounded" } })
        end,
        desc = "Jujutsu UI (cwd)",
      },
    },
  },
}
