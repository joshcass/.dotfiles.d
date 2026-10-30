-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- Keep nvim's working directory at the git root of the file being edited (or its folder outside
-- a repo), so specs run from the project root and sessions/Claude start from it. <leader>fF is
-- remapped in plugins/snacks.lua to search the current file's folder instead of the cwd.
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  group = augroup("auto_change_dir"),
  callback = function(ev)
    local name = vim.api.nvim_buf_get_name(ev.buf)
    if vim.bo[ev.buf].buftype ~= "" or name == "" then
      return
    end
    local root = vim.fs.root(ev.buf, ".git") or vim.fs.dirname(name)
    if root ~= vim.fn.getcwd(-1, -1) then
      vim.cmd.cd(root)
    end
  end,
})
