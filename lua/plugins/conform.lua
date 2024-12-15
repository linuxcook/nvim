return {
  'stevearc/conform.nvim',
  lazy = false,
  keys = {
    {
      '<leader>cf',
      function()
        require('conform').format()
      end,
      desc = 'Format',
      mode = { 'n', 'v' },
    },
    {
      '<leader>uf',
      function()
        vim.g.disable_autoformat = not vim.g.disable_autoformat
      end,
      desc = 'Toggle format on save',
    },
  },
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
  config = function(_, opts)
    local conform = require('conform')
    conform.setup(vim.tbl_extend('force', opts, {
      ---@param bufnr integer
      format_on_save = function(bufnr)
        if not vim.g.disable_autoformat and not vim.b[bufnr].disable_autoformat then
          return {
            timeout_ms = 500,
            lsp_format = 'fallback',
          }
        end
      end,
    }))
  end,
}
