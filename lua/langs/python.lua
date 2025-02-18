return {
  -- Packages
  {
    'williamboman/mason.nvim',
    opts = { ensure_installed = { 'basedpyright', 'ruff' } },
  },

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
        basedpyright = {},
      },
      on_attach = {
        ---@param client vim.lsp.Client
        ---@param buffer number
        ruff = function(client, buffer)
          client.server_capabilities.hoverProvider = false
        end,
      },
    },
  },

  -- venv
  {
    'linux-cultist/venv-selector.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
      'nvim-telescope/telescope.nvim',
    },
    lazy = false,
    branch = 'regexp', -- This is the regexp branch, use this for the new version
    opts = {
      name = '.venv',
    },
    config = function(_, opts)
      require('venv-selector').setup(opts)
    end,
    keys = {
      { 'cv', '<cmd>VenvSelect<cr>' },
    },
  },
}
