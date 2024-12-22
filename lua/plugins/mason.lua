return {
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    keys = { { '<leader>cm', '<cmd>Mason<cr>', desc = 'Mason' } },
    build = ':MasonUpdate',
    -- 'ensure_installed' is a custom option to automatically install certain lsp/formatters
    opts_extend = { 'ensure_installed' },
    config = function(_, opts)
      local ensure_installed = opts.ensure_installed or {}

      -- Setup mason before installing
      require('mason').setup()

      -- Install required packages
      local registry = require('mason-registry')
      for _, package_name in ipairs(ensure_installed) do
        local has_pkg, pkg = pcall(registry.get_package, package_name)
        if has_pkg and not pkg:is_installed() then
          vim.notify(('Installing %s'):format(package_name))
          pkg:install():once(
            'closed',
            vim.schedule_wrap(function()
              if pkg:is_installed() then
                vim.notify(('%s was successfully installed'):format(package_name), vim.log.levels.INFO)
              else
                vim.notify(
                  ('Failed to install %s. Installation logs are available in :Mason and :MasonLog'):format(package_name),
                  vim.log.levels.ERROR
                )
              end
            end)
          )
        end
      end
    end,
  },
}
