_G.Utils = require('utils')

local M = {}

function M.setup()
  require('config.autocmds')
  require('config.keymaps')
  require('config.options')
  Utils.setup()
end

return M
