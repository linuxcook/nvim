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
        },
        basedpyright = {},
      },
      setup = {
        ruff = function()
          vim.api.nvim_create_autocmd('LspAttach', {
            ---@param args vim.api.keyset.create_autocmd.callback_args
            callback = function(args)
              local client = vim.lsp.get_client_by_id(args.data.client_id) ---@type vim.lsp.Client?
              if client and client.name == 'ruff' then
                client.server_capabilities.hoverProvider = false
              end
            end,
          })
        end,
      },
    },
  },
}
