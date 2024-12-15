---@diagnostic disable: missing-fields

local map = vim.keymap.set

map('n', '<leader>cl', '<cmd>LspInfo<cr>', { desc = 'Go to Left Window' })
map('n', 'gd', vim.lsp.buf.definition, { desc = 'Goto Definition' })
map('n', 'gI', vim.lsp.buf.implementation, { desc = 'Goto Implementation' })
map('n', 'gy', vim.lsp.buf.type_definition, { desc = 'Goto Type Definition' })
map('n', 'gD', vim.lsp.buf.declaration, { desc = 'Goto Declaration' })
map('n', 'K', function()
  return vim.lsp.buf.hover()
end, { desc = 'Hover' })
map('n', 'gK', function()
  return vim.lsp.buf.signature_help()
end, { desc = 'Signature Help' })
map('i', '<c-k>', function()
  return vim.lsp.buf.signature_help()
end, { desc = 'Signature Help' })
map({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code Action' })
map({ 'n', 'v' }, '<leader>cc', vim.lsp.codelens.run, { desc = 'Run Codelens' })
map('n', '<leader>cC', vim.lsp.codelens.refresh, { desc = 'Refresh & Display Codelens' })
