--- @meta
error('Cannot require a meta file')

-- For whatever reason, the following types could not be discovered by lua_ls despite
-- existing in the source code.

-- Copied directly from neovim source code.
-- Found under `neovim/runtime/lua/vim/_meta/api_keysets_extra.lua`

--- @class vim.api.keyset.create_autocmd.callback_args
--- @field id integer autocommand id
--- @field event string name of the triggered event |autocmd-events|
--- @field group? integer autocommand group id, if any
--- @field match string expanded value of <amatch>
--- @field buf integer expanded value of <abuf>
--- @field file string expanded value of <afile>
--- @field data? any arbitrary data passed from |nvim_exec_autocmds()|                       *event-data*
