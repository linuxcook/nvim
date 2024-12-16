vim.filetype.add({
  extension = {
    jinja = 'jinja',
  },
})

return {
  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = { 'jinja' },
    },
  },
}
