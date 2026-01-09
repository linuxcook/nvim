_G.Utils = require('utils')

local M = {}

function M.setup()
  require('config.options')
  require('config.keymaps')
  require('config.autocmds')
  Utils.setup()
end

return M
