return {
  "folke/snacks.nvim",
  keys = {
    -- <leader>ff searches the project root; this searches the current file's folder
    {
      "<leader>fF",
      function()
        Snacks.picker.files({ cwd = vim.fn.expand("%:p:h") })
      end,
      desc = "Find Files (file dir)",
    },
  },
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
          hidden = true,
          layout = { preset = "default", preview = true },
        },
        files = { hidden = true },
        grep = { hidden = true },
      },
    },
  },
}
