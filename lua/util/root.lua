---@class util.root
---@overload fun(): string
local M = setmetatable({}, {
  __call = function(m)
    return m.get()
  end,
})

---@class Root
---@field paths string[]
---@field spec RootSpec

---@alias RootFn fun(buf: number): (string | string[])

---@type RootSpec[]
M.spec = { 'lsp', { '.git', 'lua' }, 'cwd' }

M.detectors = {}

function M.detectors.cwd()
  return { vim.uv.cwd() }
end

function M.detectors.lsp(buf)
  local bufpath = M.bufpath(buf)
  if not bufpath then
    return {}
  end
  local roots = {} ---@type string[]
  vim.lsp.get_clients()
  local clients = vim.lsp.get_clients({ bufnr = buf })
  for _, client in pairs(clients) do
    local workspace = client.config.workspace_folders
    for _, ws in pairs(workspace or {}) do
      roots[#roots + 1] = vim.uri_to_fname(ws.uri)
    end
    if client.root_dir then
      roots[#roots + 1] = client.root_dir
    end
  end

  return vim.tbl_filter(function(path)
    return path and bufpath:find(path, 1, true) == 1
  end, roots)
end

function M.bufpath(buf)
  return M.realpath(vim.api.nvim_buf_get_name(assert(buf)))
end

function M.cwd()
  return M.realpath(vim.uv.cwd()) or ''
end

function M.realpath(path)
  if path == '' or path == nil then
    return nil
  end
  path = vim.uv.fs_realpath(path) or path
  return path
end

-- returns the root directory based on:
-- * lsp workspace folders
-- * lsp root_dir
-- * root pattern of filename of the current buffer
-- * root pattern of cwd
---@param opts? {normalize?:boolean, buf?:number}
---@return string
function M.get(opts)
  opts = opts or {}
  local buf = opts.buf or vim.api.nvim_get_current_buf()
  local ret = M.cache[buf]
  if not ret then
    local roots = M.detect({ all = false, buf = buf })
    ret = roots[1] and roots[1].paths[1] or vim.uv.cwd()
    M.cache[buf] = ret
  end
  if opts and opts.normalize then
    return ret
  end
  return LazyVim.is_win() and ret:gsub('/', '\\') or ret
end

function M.git()
  local root = M.get()
  local git_root = vim.fs.find('.git', { path = root, upward = true })[1]
  local ret = git_root and vim.fn.fnamemodify(git_root, ':h') or root
  return ret
end
