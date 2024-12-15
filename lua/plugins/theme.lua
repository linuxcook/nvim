return {
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
    'navarasu/onedark.nvim',
    name = 'onedark',
    lazy = false,
    config = function(_, opts)
      require('onedark').setup(opts)
      require('onedark').load()
    end,
  },
}
