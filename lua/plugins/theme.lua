return {
  {
    'nvim-tree/nvim-web-devicons',
    opts = {
      override = {
        jinja = {
          icon = '',
          color = '#B41717',
          name = 'Jinja',
        },
      },
    },
    config = function(_, opts)
      require('nvim-web-devicons').setup(opts)
    end,
  },

  -- recolor devicons to match theme
  {
    'rachartier/tiny-devicons-auto-colors.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('tiny-devicons-auto-colors').setup()
    end,
  },

  -- main theme
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function(_, opts)
      require('catppuccin').setup(opts)
      vim.cmd.colorscheme('catppuccin')
    end,
  },

  { 'echasnovski/mini.cursorword', version = false, opts = {} },
  { 'echasnovski/mini.pairs', version = false, opts = {} },
}
