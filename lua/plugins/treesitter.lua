return {
  {
    'nvim-treesitter/nvim-treesitter',
    version = false,
    build = ':TSUpdate',
    opts_extend = { 'ensure_installed' },
    opts = {
      ensure_installed = { 'c', 'lua', 'vim', 'vimdoc', 'query', 'markdown', 'markdown_inline' },
      sync_install = false,
      auto_install = true,
      ignore_install = {},
      ---@type TSModule
      ---@diagnostic disable-next-line: missing-fields
      highlight = {
        enable = true,
        ---@param buf integer
        ---@return boolean?
        disable = function(_, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
      },
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
}
