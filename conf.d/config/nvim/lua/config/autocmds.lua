-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  group = augroup("auto_change_dir"),
  callback = function()
    if vim.fn.expand("%"):match("_spec.rb") then
      vim.cmd("silent! lcd `git rev-parse --show-toplevel`")
    else
      vim.cmd("silent! lcd %:p:h")
    end
  end,
})
