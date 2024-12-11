return {
  'saghen/blink.cmp',
  lazy = false,
  build = 'cargo build --release',
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  ---@diagnostic disable-next-line missing-field
  opts = {
    keymap = { preset = 'default' },
    ---@diagnostic disable-next-line missing-field
    appearance = {
      nerd_font_variant = 'mono',
    },
    ---@diagnostic disable-next-line missing-field
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
  },
}
