return {
  -- Formatting
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        cpp = { 'clang-format' },
      },
    },
  },

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'cpp' } },
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        clangd = {},
      },
    },
  },
}
