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
      servers = {
        ['*'] = {
          capabilities = {
            workspace = {
              fileOperations = {
                didRename = true,
                willRename = true,
              },
            },
          },
          -- stylua: ignore
          keys = {
            { "<leader>cl", '<cmd>LspInfo<cr>', desc = "Lsp Info" },
            { "gd", vim.lsp.buf.definition, desc = "Goto Definition", has = "definition" },
            { "gr", vim.lsp.buf.references, desc = "References", nowait = true },
            { "gI", vim.lsp.buf.implementation, desc = "Goto Implementation" },
            { "gy", vim.lsp.buf.type_definition, desc = "Goto T[y]pe Definition" },
            { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
            { "K", function() return vim.lsp.buf.hover() end, desc = "Hover" },
            { "gK", function() return vim.lsp.buf.signature_help() end, desc = "Signature Help", has = "signatureHelp" },
            { "<c-k>", function() return vim.lsp.buf.signature_help() end, mode = "i", desc = "Signature Help", has = "signatureHelp" },
            { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" },
            { "<leader>cc", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "v" }, has = "codeLens" },
            { "<leader>cC", vim.lsp.codelens.refresh, desc = "Refresh & Display Codelens", mode = { "n" }, has = "codeLens" },
            { "<leader>cr", vim.lsp.buf.rename, desc = "Rename", has = "rename" },
          },
        },
      },
    },
    config = vim.schedule_wrap(function(_, opts)
      for server, server_opts in pairs(opts.servers) do
        if server_opts.keys then
          require('plugins.lsp.keymaps').set(server, server_opts.keys)
        end
      end

      if opts.servers['*'] then
        vim.lsp.config('*', opts.servers['*'])
      end

      local function configure(server)
        if server == '*' then
          return
        end

        local sopts = opts.servers[server]
        if sopts.enabled == false then
          return
        end

        vim.lsp.config(server, sopts)
        vim.lsp.enable(server)
      end

      for server, _ in pairs(opts.servers) do
        configure(server)
      end

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local buffer = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then
            return
          end

          if opts.on_attach[client.name] then
            opts.on_attach[client.name](client, buffer)
          end

          require('plugins.lsp.keymaps').on_attach(client, buffer)

          if client:supports_method('textDocument/inlayHint') then
            vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
          end
        end,
      })
    end),
  },
}
