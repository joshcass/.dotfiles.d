return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        solargraph = { enabled = false, mason = false, autostart = false },
        rubocop = { enabled = false, mason = false, autostart = false },
        ruby_lsp = {
          mason = false,
          cmd = { vim.fn.expand("~/Documents/bonusly/special_sauce/.devbox/virtenv/ruby/bin/ruby-lsp") },
        },
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
