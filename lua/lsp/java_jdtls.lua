local M = {}
local on_attach = require'lsp.on_attach'.keymaps
M.setup = function()
  local config = {
    -- cmd = {'/home/edvard/bin/jdt-language-server-latest/bin/jdtls'},
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
      '-data', '/home/edvard/java_files'
    },
    root_dir = vim.fs.dirname(vim.fs.find({'.gradlew', '.git', 'mvnw'}, { upward = true })[1]),
    on_attach = on_attach
  }
  require('jdtls').start_or_attach(config)
end

return M
