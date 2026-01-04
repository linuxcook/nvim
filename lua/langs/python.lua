return {
  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'python' } },
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        ruff = {
          cmd_env = { RUFF_TRACE = 'messages' },
          init_options = {
            settings = {
              logLevel = 'error',
            },
          },
          keys = {
            {
              '<leader>co',
              function()
                vim.lsp.buf.code_action({
                  apply = true,
                  context = {
                    only = { 'source.organizeImports' },
                    diagnostics = {},
                  },
                })
              end,
              desc = 'Organize Imports',
            },
          },
        },
        ty = {},
      },
      on_attach = {
        ---@param client vim.lsp.Client
        ruff = function(client, _)
          client.server_capabilities.hoverProvider = false
        end,
      },
    },
  },
}
