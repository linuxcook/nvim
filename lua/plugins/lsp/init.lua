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

      local has_blink, blink = pcall(require, 'blink.cmp')
      local capabilities = vim.tbl_deep_extend(
        'force',
        {},
        vim.lsp.protocol.make_client_capabilities() or {},
        has_blink and blink.get_lsp_capabilities() or {},
        opts.capabilities or {}
      )

      local servers = opts.servers or {}
      for server, config in pairs(servers) do
        local server_opts = vim.tbl_deep_extend('force', { capabilities = vim.deepcopy(capabilities) }, config or {})
        if server_opts.enabled == false then
          return
        end

        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        end
        lspconfig[server].setup(server_opts)
      end

      require('plugins.lsp.keymaps')
    end,
  },
}
