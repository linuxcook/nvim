return {
  -- Packages
  {
    'williamboman/mason.nvim',
    opts = { ensure_installed = { 'gopls' } },
  },

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'go' } },
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        gopls = {},
      },
    },
  },
}
