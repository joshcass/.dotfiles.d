return {
  dir = "~/Documents/watchtower-mode",
  name = "watchtower",
  lazy = false,
  opts = {
    open_on_startup = true, -- opens right away when nvim starts inside a git repo
    open_on_file = true, -- otherwise: dashboard first, view opens with the first repo file you open
    open_file = {
      mode = "split", -- or "replace" to open in the diff window
      direction = "away", -- away (side of the diff opposite the tree) | above | below
    },
  },
  keys = {
    { "<leader>gw", "<cmd>Watchtower<cr>", desc = "Watchtower (diff view)" },
  },
}
