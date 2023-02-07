local M = {}
local pid = vim.fn.getpid()
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = '/home/edvard/sources/dev/' .. project_name
M.setup = function(lsp_flags, capabilities, on_attach)
  require('lspconfig')['jdtls'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    root_dir = function()
      vim.fs.dirname(vim.fs.find({'.gradlew', '.git', 'mvnw'}, { upward = true })[1])
    end,
    cmd = {
      '/home/edvard/bin/jdk-17.0.6/bin/java',
      '-Declipse.application=org.eclipse.jdt.ls.core.id1',
      '-Dosgi.bundles.defaultStartLevel=4',
      '-Declipse.product=org.eclipse.jdt.ls.core.product',
      '-Dlog.protocol=true',
      '-Dlog.level=ALL',
      '-Xms1g',
      '--add-modules=ALL-SYSTEM',
      '--add-opens', 'java.base/java.util=ALL-UNNAMED',
      '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
      '-jar', '/home/edvard/bin/jdt-language-server-latest/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
      '-configuration', '/home/edvard/bin/jdt-language-server-latest/config_linux',
      '-data', workspace_dir,
      '--languageserver',
      '--hostPID', tostring(pid) 
    },
  }
end

return M
