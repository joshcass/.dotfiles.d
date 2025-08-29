return {
  "joshcass/claude-code.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim", -- Required for git operations
  },
  config = function()
    require("claude-code").setup({
      window = {
        split_ratio = 0.3, -- Percentage of screen for the terminal window (height for horizontal, width for vertical splits)
        position = "vertical", -- Position of the window: "botright", "topleft", "vertical", "float", etc.
      },
      keymaps = {
        toggle = {
          normal = "<C-,>", -- Normal mode keymap for toggling Claude Code, false to disable
          terminal = "<C-,>", -- Terminal mode keymap for toggling Claude Code, false to disable
          variants = {
            continue = "<leader>ar", -- Normal mode keymap for Claude Code with continue flag
            verbose = "<leader>av", -- Normal mode keymap for Claude Code with verbose flag
          },
        },
        send_file_path = "<leader>af", -- Send current file path to Claude Code
      },
    })
  end,
}
