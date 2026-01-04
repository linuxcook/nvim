return {
  -- Formatting
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        css = { 'prettier', 'prettierd' },
        html = { 'prettier', 'prettierd' },
        javascript = { 'prettier', 'prettierd' },
        typescript = { 'prettier', 'prettierd' },
        vue = { 'prettier', 'prettierd' },
      },
    },
  },

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = { 'css', 'html', 'javascript', 'jsdoc', 'regex', 'typescript', 'vue' },
    },
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        ts_ls = {
          filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
          init_options = {
            plugins = {
              {
                name = '@vue/typescript-plugin',
                location = vim.fn.stdpath('data')
                  .. '/mason/packages/vue-language-server/node_modules/@vue/language-server',
                languages = { 'vue' },
              },
            },
          },
        },
        vue_ls = {},
      },
    },
  },
}
