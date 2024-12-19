return {
  'stevearc/oil.nvim',
  lazy = true,
  keys = {
    { '-', '<cmd>Oil<cr>', desc = 'Open parent directory' },
  },
  config = function()
    require('oil').setup()
  end,
}
