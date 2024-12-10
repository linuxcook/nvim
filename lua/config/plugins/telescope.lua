return {
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    version = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    keys = {
      {
        '<leader>,',
        '<CMD>Telescope buffers sort_mru=true sort_lastused=true<CR>',
        desc = 'Switch Buffer',
      },
      {
        '<leader>/',
        '<CMD>Telescope live_grep<CR>',
        'Grep (Root Dir)',
      },
      {
        '<leader>:',
        '<cmd>Telescope command_history<cr>',
        desc = 'Command History',
      },
      {
        '<leader><space>',
        '<cmd>Telescope find_files<CR>',
        desc = 'Find Files (Root Dir)',
      },
      -- find
      {
        '<leader>fb',
        '<cmd>Telescope buffers sort_mru=true sort_lastused=true ignore_current_buffer=true<cr>',
        desc = 'Buffers',
      },
      {
        '<leader>fc',
        function()
          require('telescope.builtin').find_files({
            cwd = vim.fn.stdpath('config'),
          })
        end,
        desc = 'Find Config File',
      },
      { '<leader>ff', '<cmd>Telescope find_files<CR>',                desc = 'Find Files (Root Dir)' },
      { '<leader>fF', '<cmd>Telescope find_files<CR>',                desc = 'Find Files (cwd)' },
      { '<leader>fg', '<cmd>Telescope git_files<cr>',                 desc = 'Find Files (git-files)' },
      { '<leader>fr', '<cmd>Telescope oldfiles<cr>',                  desc = 'Recent' },
      -- git
      { '<leader>gc', '<cmd>Telescope git_commits<CR>',               desc = 'Commits' },
      { '<leader>gs', '<cmd>Telescope git_status<CR>',                desc = 'Status' },
      -- search
      { '<leader>s"', '<cmd>Telescope registers<cr>',                 desc = 'Registers' },
      { '<leader>sa', '<cmd>Telescope autocommands<cr>',              desc = 'Auto Commands' },
      { '<leader>sb', '<cmd>Telescope current_buffer_fuzzy_find<cr>', desc = 'Buffer' },
      { '<leader>sc', '<cmd>Telescope command_history<cr>',           desc = 'Command History' },
      { '<leader>sC', '<cmd>Telescope commands<cr>',                  desc = 'Commands' },
      { '<leader>sd', '<cmd>Telescope diagnostics bufnr=0<cr>',       desc = 'Document Diagnostics' },
      { '<leader>sD', '<cmd>Telescope diagnostics<cr>',               desc = 'Workspace Diagnostics' },
      { '<leader>sg', '<cmd>Telescope live_grep<cr>',                 desc = 'Grep (Root Dir)' },
      { '<leader>sG', '<cmd>Telescope live_grep<cr>',                 desc = 'Grep (cwd)' },
      { '<leader>sh', '<cmd>Telescope help_tags<cr>',                 desc = 'Help Pages' },
      { '<leader>sH', '<cmd>Telescope highlights<cr>',                desc = 'Search Highlight Groups' },
      { '<leader>sj', '<cmd>Telescope jumplist<cr>',                  desc = 'Jumplist' },
      { '<leader>sk', '<cmd>Telescope keymaps<cr>',                   desc = 'Key Maps' },
      { '<leader>sl', '<cmd>Telescope loclist<cr>',                   desc = 'Location List' },
      { '<leader>sM', '<cmd>Telescope man_pages<cr>',                 desc = 'Man Pages' },
      { '<leader>sm', '<cmd>Telescope marks<cr>',                     desc = 'Jump to Mark' },
      { '<leader>so', '<cmd>Telescope vim_options<cr>',               desc = 'Options' },
      { '<leader>sR', '<cmd>Telescope resume<cr>',                    desc = 'Resume' },
      { '<leader>sq', '<cmd>Telescope quickfix<cr>',                  desc = 'Quickfix List' },
      { '<leader>sw', '<cmd>Telescope grep_string<cr>',               desc = 'Word (Root Dir)' },
      { '<leader>sW', '<cmd>Telescope grep_string<cr>',               desc = 'Word (cwd)' },
      {
        '<leader>sw',
        '<cmd>Telescope grep_string<cr>',
        mode = 'v',
        desc = 'Selection (Root Dir)',
      },
      {
        '<leader>sW',
        '<cmd>Telescope grep_string<cr>',
        mode = 'v',
        desc = 'Selection (cwd)',
      },
      { '<leader>uC', '<cmd>Telescope colorscheme<cr>', desc = 'Colorscheme with Preview' },
    },
    config = function()
      local actions = require("telescope.actions")
      local telescope = require('telescope')
      telescope.setup({
        mappings = {
          n = {
            ["q"] = actions.close,
          },
        },
        pickers = {
          find_files = {
            theme = 'ivy',
          },
        },
        extensions = {
          fzf = {},
        },
      })

      telescope.load_extension('fzf')
    end,
  },
}
