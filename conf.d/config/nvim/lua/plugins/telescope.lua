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
    },
    config = function(_, opts)
      require("telescope").setup(opts)
      require("telescope").load_extension("file_browser")
    end,
  },
}
