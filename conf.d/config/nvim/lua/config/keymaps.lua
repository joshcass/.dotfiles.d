-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local unmap = vim.keymap.del

-- My mappings
map("n", "<leader>fy", "<cmd>let @+ = expand('%:p')<cr>", { desc = "Yank file path" })
map("n", "<leader>fD", "<cmd>call delete(expand('%:p')) | bdelete!<cr>", { desc = "Delete file" })
map("n", "\\", "<C-w>", { desc = "Show Window menu", remap = true })
map("n", "<leader>gt", "<cmd>Tardis git<cr>", { desc = "Git Tardis" })

if vim.g.neovide then
  map("n", "<F11>", function()
    if vim.g.neovide_fullscreen then
      vim.g.neovide_fullscreen = false
    else
      vim.g.neovide_fullscreen = true
    end
  end, { desc = "Toggle fullscreen" })

  map("n", "<leader>uB", function()
    if vim.g.neovide_scale_factor == 1 then
      vim.g.neovide_scale_factor = 1.25
    else
      vim.g.neovide_scale_factor = 1
    end
  end, { desc = "Toggle big mode" })
end
