return {
  -- Packages
  {
    'williamboman/mason.nvim',
    opts = { ensure_installed = { 'yamlfmt', 'yaml-language-server' } },
  },

  -- Formatting
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        yaml = { 'yamlfmt' },
      },
    },
  },

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'yaml' } },
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        yamlls = {},
      },
    },
  },
}
