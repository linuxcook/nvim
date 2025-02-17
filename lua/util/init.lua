---@class util
---@field root util.root
local M = {}

setmetatable(M, {
  __index = function(t, k)
    t[k] = require('util.' .. k)
    return t[k]
  end,
})

function M.lazy_file()
  local Event = require('lazy.core.handler.event')
  Event.mappings.LazyFile = { id = 'LazyFile', event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' } }
end

function M.is_win()
  return vim.uv.os_uname().sysname:find('Windows') ~= nil
end

---@param fn fun()
function M.on_very_lazy(fn)
  vim.api.nvim_create_autocmd('User', {
    pattern = 'VeryLazy',
    callback = function()
      fn()
    end,
  })
end

---@generic T
---@param list T[]
---@return T[]
function M.dedup(list)
  local ret = {}
  local seen = {}
  for _, v in ipairs(list) do
    if not seen[v] then
      table.insert(ret, v)
      seen[v] = true
    end
  end
  return ret
end

return M
