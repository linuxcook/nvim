return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'saghen/blink.cmp',
      'williamboman/mason.nvim',
    },
    config = function(_, opts)
      local lspconfig = require('lspconfig')
      vim.api.nvim_create_autocmd('LspAttach', {
        ---@param args vim.api.keyset.create_autocmd.callback_args
        callback = function(args)
          ---@type vim.lsp.Client?
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then
            return
          end

          if client.supports_method('textDocument/inlayHint') then
            vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
          end

          if client.supports_method('textDocument/codeLens') then
            vim.api.nvim_create_autocmd({ 'BufEnter', 'InsertLeave' }, {
              buffer = args.buf,
              callback = vim.lsp.codelens.refresh,
            })
          end
        end,
      })

      local capabilities = nil
      if pcall(require, 'blink.cmp') then
        capabilities = require('blink.cmp').get_lsp_capabilities()
      end

      local servers = opts.servers or {}
      for server, config in pairs(servers) do
        config.capabilities = capabilities
        lspconfig[server].setup(config)
      end

      require('plugins.lsp.keymaps')
    end,
  },
}
