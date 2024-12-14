return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'saghen/blink.cmp',
      'williamboman/mason.nvim',
      { 'williamboman/mason-lspconfig.nvim', config = function() end },
      {
        'folke/lazydev.nvim',
        ft = 'lua', -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
          },
        },
      },
    },
    config = function()
      local lspconfig = require('lspconfig')

      -- Autoformat
      vim.api.nvim_create_autocmd('LspAttach', {
        ---@param args vim.api.keyset.create_autocmd.callback_args
        callback = function(args)
          ---@type vim.lsp.Client?
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then
            return
          end
          if client.supports_method('textDocument/formatting') then
            -- Format the current buffer on save
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
              end,
            })
          end

          if client.supports_method('textDocument/inlayHint') then
            vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
          end

          if client.supports_method('textDocument/codeLens') then
            vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
              buffer = args.buf,
              callback = vim.lsp.codelens.refresh,
            })
          end
        end,
      })

      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- Clangd
      lspconfig.clangd.setup({
        capabilities = capabilities,
      })

      -- lua-language-server
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        ---@param client vim.lsp.Client
        on_init = function(client)
          if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
              return
            end
          end

          client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
              version = 'LuaJIT',
            },
            workspace = {
              checkThirdParty = false,
              -- library = {
              --   vim.env.VIMRUNTIME,
              -- },
              library = vim.api.nvim_get_runtime_file('', true),
            },
          })
        end,
        settings = {
          Lua = {
            hint = { enable = true },
            codelens = { enable = true },
          },
        },
      })

      -- configure keys
    end,
  },
}
