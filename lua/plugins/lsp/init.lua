return {
  {
    'neovim/nvim-lspconfig',
    event = 'LazyFile',
    dependencies = {
      'saghen/blink.cmp',
      'williamboman/mason.nvim',
    },
    opts = {
      on_attach = {},
      setup = {},
    },
    config = function(_, opts)
      local servers = opts.servers or {}
      local has_blink, blink = pcall(require, 'blink.cmp')
      local capabilities = vim.tbl_deep_extend(
        'force',
        {},
        vim.lsp.protocol.make_client_capabilities() or {},
        has_blink and blink.get_lsp_capabilities() or {},
        opts.capabilities or {}
      )

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
        require('lspconfig')[server].setup(server_opts)
      end

      vim.api.nvim_create_autocmd('LspAttach', {
        ---@param args vim.api.keyset.create_autocmd.callback_args
        callback = function(args)
          local buffer = args.buf ---@type number
          local client = vim.lsp.get_client_by_id(args.data.client_id) ---@type vim.lsp.Client?
          if not client then
            return
          end

          if opts.on_attach[client.name] then
            opts.on_attach[client.name](client, buffer)
          end

          require('plugins.lsp.keymaps').on_attach(client, buffer)

          if client.supports_method('textDocument/inlayHint') then
            vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
          end

          if client.supports_method('textDocument/codeLens') then
            vim.lsp.codelens.refresh()
            vim.api.nvim_create_autocmd({ 'BufEnter', 'InsertLeave' }, {
              buffer = buffer,
              callback = vim.lsp.codelens.refresh,
            })
          end
        end,
      })
    end,
  },
}
