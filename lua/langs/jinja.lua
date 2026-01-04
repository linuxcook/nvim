return {
  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function()
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

      return { ensure_installed = { 'jinja2' } }
    end,
  },
}
