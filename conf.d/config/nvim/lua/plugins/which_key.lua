return {
  { "folke/which-key.nvim", opts = {
    icons = {
      mappings = false,
    },
  } },
  require("which-key").add({
    { "<leader>o", group = "open" },
  }),
}
