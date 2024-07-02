return {
  {
    "nvim-pack/nvim-spectre",
    keys = {
      { "<leader>sR", function() require("spectre").open() end, desc = "Replace in Files (Spectre)" },
    },
  }
}
