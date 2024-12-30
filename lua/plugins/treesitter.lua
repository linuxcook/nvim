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
      ---@type TSModule
      ---@diagnostic disable-next-line: missing-fields
      highlight = {
        enable = true,
        ---@param buf integer
        disable = function(_, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
      },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<c-space>',
          node_incremental = '<c-space>',
          scope_incremental = false,
          node_decremental = '<bs>',
        },
      },
    },
    config = function(_, opts)
      local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
      parser_config['jinja2'] = {
        install_info = {
          url = 'https://github.com/linuxcook/tree-sitter-jinja2',
          files = { 'src/parser.c', 'src/scanner.c' },
          branch = 'main',
          generate_requires_npm = false,
          requires_generate_from_grammar = false,
        },
        filetype = 'jinja',
      }

      if type(opts.ensure_installed) == 'table' then
        opts.ensure_installed = Util.dedup(opts.ensure_installed)
      end
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
}
