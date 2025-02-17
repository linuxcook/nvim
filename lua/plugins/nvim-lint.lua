return {
  {
    'mfussenegger/nvim-lint',
    event = 'LazyFile',
    opts = {
      linters_by_ft = {},
    },
    config = function(_, opts)
      local lint = require('lint')

      lint.linters_by_ft = opts.linters_by_ft or {}

      -- create linting autocmd
      vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost', 'InsertLeave' }, {
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
