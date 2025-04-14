local state = {
  win = -1,
}

local function create_floating_window(opts)
  opts = opts or {}

  -- Get current Neovim UI size
  local ui = vim.api.nvim_list_uis()[1]
  local screen_width = ui.width
  local screen_height = ui.height

  -- Default width/height to 80% of the screen
  local width = opts.width or math.floor(screen_width * 0.8)
  local height = opts.height or math.floor(screen_height * 0.8)

  -- Center the window
  local col = math.floor((screen_width - width) / 2)
  local row = math.floor((screen_height - height) / 2)

  -- Create a new scratch buffer
  local buf = vim.api.nvim_create_buf(false, true)

  -- Get the directory of the current buffer
  local curr_buff = vim.api.nvim_get_current_buf()
  local buff_path = vim.api.nvim_buf_get_name(curr_buff)
  local dir = vim.fn.fnamemodify(buff_path, ':p:h')

  -- Window options
  local win_opts = {
    relative = 'editor',
    width = width,
    height = height,
    col = col,
    row = row,
    style = 'minimal',
    border = 'rounded',
  }

  if 0 == vim.fn.isdirectory(dir) then
    vim.notify('[Fterm]: Not a valid directory', vim.log.levels.WARN)
    return -1
  end

  -- Open the floating window
  local win = vim.api.nvim_open_win(buf, true, win_opts)

  -- Start terminal in that directory
  local shell = os.getenv('SHELL') or '/bin/sh'
  local _ = vim.fn.jobstart(shell, {
    term = true,
    cwd = dir,
    on_exit = function()
      if vim.api.nvim_win_is_valid(win) then
        vim.api.nvim_win_close(win, true)
      end
    end,
  })

  local function close()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end

  -- Set buffer-local keymaps
  vim.keymap.set('n', 'q', close, { buffer = buf, nowait = true, silent = true })
  vim.keymap.set({ 'n', 't' }, '<Esc>', close, { buffer = buf, nowait = true, silent = true })

  vim.cmd('startinsert')

  return win
end

vim.api.nvim_create_user_command('Fterm', function()
  if not vim.api.nvim_win_is_valid(state.win) then
    local ok, win = pcall(create_floating_window)
    if not ok then
      vim.notify('[Fterm Error]: ' .. win, vim.log.levels.ERROR)
      return
    end
    state.win = win
  else
    vim.api.nvim_win_close(state.win, true)
  end
end, {})

vim.keymap.set('n', '<leader>t', '<cmd>Fterm<cr>', { desc = 'Floating Terminal' })

return {}
