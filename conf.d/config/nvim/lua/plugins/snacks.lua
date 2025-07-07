return {
  "folke/snacks.nvim",
  opts = {
    indent = { enabled = false },
    explorer = {
      replace_netrw = true, -- Replace netrw with the snacks explorer
    },
    picker = {
      sources = {
        explorer = {
          tree = false,
          auto_close = true,
          layout = { preset = "default", preview = true },
        },
      },
    },
  },
}
