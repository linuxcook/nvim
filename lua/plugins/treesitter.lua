return {
  {
    'nvim-treesitter/nvim-treesitter',
    version = false,
    build = ':TSUpdate',
    opts_extend = { 'ensure_installed' },
    ---@type TSConfig
    ---@diagnostic disable-next-line: missing-fields
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
          local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
      },
    },
    config = function(_, opts)
      local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
      parser_config['jinja'] = {
        install_info = {
          url = 'https://github.com/lxc23/tree-sitter-jinja2',
          files = { 'src/parser.c', 'src/scanner.c' },
          branch = 'main',
        },
        filetype = 'jinja',
      }

      require('nvim-treesitter.configs').setup(opts)
    end,
  },
}
