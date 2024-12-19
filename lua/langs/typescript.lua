return {
  -- Formatting
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        javascript = { 'prettierd' },
        typescript = { 'prettierd' },
      },
    },
  },

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'javascript', 'typescript' } },
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        ts_ls = {},
      },
    },
  },
}
