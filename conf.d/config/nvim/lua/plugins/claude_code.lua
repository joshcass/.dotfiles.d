return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  opts = {
    terminal_cmd = "direnv exec . ~/.local/bin/claude", -- Launch with direnv environment
    git_repo_cwd = true, -- prevent claude from scattering .claude folders all over
    terminal = {
      split_side = "right",
      split_width_percentage = 0.50,
    },
    -- Diff Integration
    diff_opts = {
      auto_close_on_accept = true,
      vertical_split = false,
      open_in_current_tab = true,
      keep_terminal_focus = true, -- If true, moves focus back to terminal after diff opens (including floating terminals)
    },
  },
  config = function(_, opts)
    require("claudecode").setup(opts)

    -- Auto-accept diffs without opening diff view in neovim
    vim.api.nvim_create_autocmd("User", {
      pattern = "ClaudeCodeStarted",
      callback = function()
        local ok, diff = pcall(require, "claudecode.diff")
        if not ok then
          return
        end

        diff.open_diff_blocking = function(file_path, new_content, opts)
          -- Just write the file directly - you already reviewed in terminal
          vim.fn.mkdir(vim.fn.fnamemodify(file_path, ":h"), "p")
          local file = io.open(file_path, "w")
          if file then
            file:write(new_content)
            file:close()
            -- Reload buffer if it's open
            local bufnr = vim.fn.bufnr(file_path)
            if bufnr ~= -1 then
              vim.api.nvim_buf_call(bufnr, function()
                vim.cmd("edit!")
              end)
            end
          end
          return { accepted = true }
        end
      end,
    })
  end,
  keys = {
    { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
    { "<C-,>", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
    { "<C-,>", "<cmd>ClaudeCode<cr>", mode = "t", desc = "Toggle Claude" },
    { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
    { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
    { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
    { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
    { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
    { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
    -- Diff management
    { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
    { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
  },
}
