return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-telescope/telescope-file-browser.nvim" },
    },
    opts = {
      extensions = {
        file_browser = {
          hijack_netrw = true,
        },
      },
    },
    keys = {
      { "<leader>fB", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
      {
        "<leader>fb",
        function()
          require("telescope").extensions.file_browser.file_browser()
        end,
        desc = "File browser",
      },
      { "<leader>fF", LazyVim.pick("auto"), desc = "Find Files (Root Dir)" },
      { "<leader>ff", LazyVim.pick("auto", { root = false }), desc = "Find Files (cwd)" },
      { "<leader>sR", false }, -- need to unset the telescope default because we are remapping it in grug-far
      { "<leader>sr", "<cmd>Telescope resume<cr>", desc = "Resume" },
      { "<leader>sW", LazyVim.pick("grep_string", { word_match = "-w" }), desc = "Word (Root Dir)" },
      { "<leader>sw", LazyVim.pick("grep_string", { root = false, word_match = "-w" }), desc = "Word (cwd)" },
      { "<leader>sW", LazyVim.pick("grep_string"), mode = "v", desc = "Selection (Root Dir)" },
      { "<leader>sw", LazyVim.pick("grep_string", { root = false }), mode = "v", desc = "Selection (cwd)" },
    },
    config = function(_, opts)
      require("telescope").setup(opts)
      require("telescope").load_extension("file_browser")
    end,
  },
}
