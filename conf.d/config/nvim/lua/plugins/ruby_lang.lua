return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      -- direnv.vim loads PATH after startup, so the first ruby buffer may try to start ruby-lsp before it's on PATH
      vim.api.nvim_create_autocmd("User", {
        pattern = "DirenvLoaded",
        callback = function()
          if vim.fn.executable("ruby-lsp") == 1 then
            vim.lsp.enable("ruby_lsp")
          end
        end,
      })
    end,
    opts = {
      servers = {
        -- Use the project's devbox ruby-lsp from PATH so it runs under the project ruby
        ruby_lsp = { mason = false },
      },
    },
  },
  {
    "nvim-neotest/neotest",
    opts = {
      adapters = {
        ["neotest-rspec"] = {
          -- NOTE: By default neotest-rspec uses the system wide rspec gem instead of the one through bundler
          rspec_cmd = function()
            return vim
              .iter({
                "bundle",
                "exec",
                "rspec",
              })
              :flatten()
              :totable()
          end,
        },
      },
    },
  },
}
