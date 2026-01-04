local M = {}

---@type {string: LazyKeysLspSpec[]}
M._keys = {}

---@alias LazyKeysLspSpec LazyKeysSpec|{has?:string|string[], cond?:fun():boolean}
---@alias LazyKeysLsp LazyKeys|{has?:string|string[], cond?:fun():boolean}

---@param buffer number
---@param method string|string[]
function M.has(buffer, method)
  if type(method) == 'table' then
    for _, m in ipairs(method) do
      if M.has(buffer, m) then
        return true
      end
    end
    return false
  end
  method = method:find('/') and method or 'textDocument/' .. method
  local clients = vim.lsp.get_clients({ bufnr = buffer })
  for _, client in ipairs(clients) do
    if client:supports_method(method) then
      return true
    end
  end
  return false
end

---@param server string
---@return LazyKeysLsp[]
function M.resolve(server)
  local Keys = require('lazy.core.handler.keys')
  if not Keys.resolve then
    return {}
  end

  return Keys.resolve(vim.tbl_extend('force', {}, M._keys['*'] or {}, M._keys[server] or {}))
end

---@param server string
---@param keys LazyKeysLspSpec[]
function M.set(server, keys)
  M._keys[server] = keys
end

---@param client vim.lsp.Client
---@param buffer number
function M.on_attach(client, buffer)
  local Keys = require('lazy.core.handler.keys')
  local keymaps = M.resolve(client.name)

  for _, keys in pairs(keymaps) do
    local has = not keys.has or M.has(buffer, keys.has)
    local cond = not (keys.cond == false or ((type(keys.cond) == 'function') and not keys.cond()))

    if has and cond then
      local opts = Keys.opts(keys) ---@type LazyKeysLsp
      opts.cond = nil
      opts.has = nil
      ---@cast opts vim.keymap.set.Opts
      opts.silent = opts.silent ~= false
      opts.buffer = buffer
      vim.keymap.set(keys.mode or 'n', keys.lhs, keys.rhs, opts)
    end
  end
end

return M
