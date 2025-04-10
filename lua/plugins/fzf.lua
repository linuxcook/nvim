return {
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    winopts = {
      split = 'belowright new',
    },
    keymap = {
      builtin = {
        true,
        ['<C-d>'] = 'preview-page-down',
        ['<C-u>'] = 'preview-page-up',
      },
      fzf = {
        true,
        ['ctrl-d'] = 'preview-page-down',
        ['ctrl-u'] = 'preview-page-up',
        ['ctrl-q'] = 'select-all+accept',
      },
    },
    actions = {},
    buffers = {},
  },
  config = function(_, opts)
    local actions = require('fzf-lua').actions

    opts.actions = {
      files = {
        ['enter'] = actions.file_edit_or_qf,
        ['ctrl-x'] = actions.file_split,
        ['ctrl-v'] = actions.file_vsplit,
        ['ctrl-t'] = actions.file_tabedit,
        ['alt-q'] = actions.file_sel_to_qf,
      },
    }

    opts.buffers = {
      keymap = { builtin = { ['<C-d'] = false } },
      actions = { ['ctrl-x'] = false, ['ctrl-d'] = { actions.buf_del, actions.resume } },
    }

    require('fzf-lua').setup(opts)
  end,
  -- stylua: ignore start
  keys = {
    -- Top Pickers & Explorer
    { '<leader><space>', function () require('fzf-lua').files() end, desc = 'Find Files' },
    { '<leader>,', function() require('fzf-lua').buffers() end, desc = 'Buffers' },
    { '<leader>/', function() require('fzf-lua').live_grep() end, desc = 'Grep' },
    { '<leader>:', function() require('fzf-lua').command_history() end, desc = 'Command History' },
    -- find
    { '<leader>fb', function() require('fzf-lua').buffers() end, desc = 'Buffers' },
    { '<leader>fc', function() require('fzf-lua').files({ cwd = vim.fn.stdpath('config') }) end, desc = 'Find Config File' },
    { '<leader>ff', function() require('fzf-lua').files() end, desc = 'Find Files' },
    { '<leader>fg', function() require('fzf-lua').git_files() end, desc = 'Find Git Files' },
    { '<leader>fr', function() require('fzf-lua').old_files() end, desc = 'Recent' },
    -- git
    { '<leader>gf', function() require('fzf-lua').git_files() end, desc = 'Find Files (git)' },
    { '<leader>gb', function() require('fzf-lua').git_commits() end, desc = 'Git Branches' },
    { '<leader>gs', function() require('fzf-lua').git_status() end, desc = 'Git Status' },
    -- grep
    { '<leader>sb', function() require('fzf-lua').grep_curbuf() end, desc = 'Buffer Lines' },
    { '<leader>sg', function() require('fzf-lua').grep() end, desc = 'Grep' },
    { '<leader>sw', function() require('fzf-lua').grep_cword() end, desc = 'Visual selection or word' },
    -- search
    { "<leader>s'", function() require('fzf-lua').registers() end, desc = 'Registers' },
    { '<leader>s/', function() require('fzf-lua').search_history() end, desc = 'Search History' },
    { '<leader>sa', function() require('fzf-lua').autocmds() end, desc = 'Autocmds' },
    { '<leader>sb', function() require('fzf-lua').lines() end, desc = 'Buffer Lines' },
    { '<leader>sc', function() require('fzf-lua').command_history() end, desc = 'Command History' },
    { '<leader>sC', function() require('fzf-lua').commands() end, desc = 'Commands' },
    { '<leader>sd', function() require('fzf-lua').diagnostics_workspace() end, desc = 'Diagnostics' },
    { '<leader>sD', function() require('fzf-lua').diagnostics_document() end, desc = 'Buffer Diagnostics' },

    { '<leader>sH', function() require('fzf-lua').highlights() end, desc = 'Highlights' },
    { '<leader>sj', function() require('fzf-lua').jumps() end, desc = 'Jumps' },
    { '<leader>sk', function() require('fzf-lua').keymaps() end, desc = 'Keymaps' },
    { '<leader>sl', function() require('fzf-lua').loclist() end, desc = 'Location List' },
    { '<leader>sm', function() require('fzf-lua').marks() end, desc = 'Marks' },
    { '<leader>sq', function() require('fzf-lua').quickfix() end, desc = 'Quickfix List' },
    { '<leader>sR', function() require('fzf-lua').resume() end, desc = 'Resume' },
    { '<leader>uC', function() require('fzf-lua').colorschemes() end, desc = 'Colorschemes' },
    -- LSP
    { 'gd', function() require('fzf-lua').lsp_definitions() end, desc = 'Goto Definition' },
    { 'gD', function() require('fzf-lua').lsp_declarations() end, desc = 'Goto Declaration' },
    { 'gr', function() require('fzf-lua').lsp_references() end, nowait = true, desc = 'References' },
    { 'gI', function() require('fzf-lua').lsp_implementations() end, desc = 'Goto Implementation' },
    { 'gy', function() require('fzf-lua').lsp_typedefs() end, desc = 'Goto Type Definition' },
    { '<leader>ss', function() require('fzf-lua').lsp_document_symbols() end, desc = 'LSP Symbols' },
    { '<leader>sS', function() require('fzf-lua').lsp_workspace_symbols() end, desc = 'LSP Workspace Symbols' },
  },
  -- stylua: ignore end
}
