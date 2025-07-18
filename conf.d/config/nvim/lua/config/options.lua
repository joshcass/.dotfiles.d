-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
vim.g.lazyvim_ruby_lsp = "ruby_lsp"
vim.g.lazyvim_ruby_formatter = "rubocop"
vim.g.direnv_silent_load = 1

vim.opt.relativenumber = false
vim.opt.scrolloff = 999

vim.g.terminal_color_0 = "#073642"
vim.g.terminal_color_1 = "#dc322f"
vim.g.terminal_color_2 = "#859900"
vim.g.terminal_color_3 = "#b58900"
vim.g.terminal_color_4 = "#268bd2"
vim.g.terminal_color_5 = "#d33682"
vim.g.terminal_color_6 = "#2aa198"
vim.g.terminal_color_7 = "#eee8d5"
vim.g.terminal_color_8 = "#002b36"
vim.g.terminal_color_9 = "#cb4b16"
vim.g.terminal_color_10 = "#586e75"
vim.g.terminal_color_11 = "#657b83"
vim.g.terminal_color_12 = "#839496"
vim.g.terminal_color_13 = "#6c71c4"
vim.g.terminal_color_14 = "#93a1a1"
vim.g.terminal_color_15 = "#fdf6e3"

if vim.g.neovide then
  vim.g.neovide_theme = "light"
  vim.g.neovide_hide_mouse_when_typing = true
end
