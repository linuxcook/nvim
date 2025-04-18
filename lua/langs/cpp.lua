return {
  -- Formatting
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        cmake = { 'cmake_format' },
        cpp = { 'clang-format' },
      },
    },
  },

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'cpp', 'cmake', 'doxygen', 'comment' } },
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        clangd = {},
        neocmake = {},
      },
    },
  },
}
