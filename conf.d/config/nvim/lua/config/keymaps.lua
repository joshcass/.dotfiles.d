-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local unmap = vim.keymap.del

-- My mappings
map("n", "<leader>fy", "<cmd>let @+ = expand('%:p')<cr>", { desc = "Yank file path" })
map("n", "<leader>fD", "<cmd>call delete(expand('%:p')) | bdelete!<cr>", { desc = "Delete file" })
map("n", "\\", "<C-w>", { desc = "Show Window menu", remap = true })

if vim.g.neovide then
  map("n", "<F11>", function()
    if vim.g.neovide_fullscreen then
      vim.g.neovide_fullscreen = false
    else
      vim.g.neovide_fullscreen = true
    end
  end, { desc = "Toggle fullscreen" })
end

-- Terminal Mappings
-- Unset lazyvim defaults
unmap("n", "<leader>ft")
unmap("n", "<leader>fT")
unmap("t", "<C-h>")
unmap("t", "<C-j>")
unmap("t", "<C-k>")
unmap("t", "<C-l>")

map("n", "<leader>oT", function()
  LazyVim.terminal(nil, { cwd = LazyVim.root() })
end, { desc = "Terminal (Root Dir)" })

map("n", "<leader>ot", function()
  LazyVim.terminal()
end, { desc = "Terminal (cwd)" })
