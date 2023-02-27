local M = {}
local on_attach_base = require'lsp.on_attach'.keymaps
local on_attach = function(client, bufnr)
  on_attach_base(client, bufnr)
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  -- vim.keymap.set('n', 'tf', '<cmd>lua require\'jdtls\'.test_class<cr>', bufopts)
  -- vim.keymap.set('n', 'tn', '<cmd>lua require\'jdtls\'.test_nearest_method<cr>', bufopts)
  -- With `hotcodereplace = 'auto' the debug adapter will try to apply code changes
  -- you make during a debug session immediately.
  -- Remove the option if you do not want that.
  require('jdtls').setup_dap({ hotcodereplace = 'auto' })
end

require('dap.ext.vscode').load_launchjs()
local bundles = {
  vim.fn.glob('/home/edvard/.cache/nvim/com.microsoft.java.debug.plugin-0.44.0.jar')
}
-- I dont think these bundles are really neccesary
vim.list_extend(bundles, vim.split(vim.fn.glob("/home/edvard/.cache/nvim/vscode-java-test/server/*.jar", 1), "\n"))
M.setup = function()
  local config = {
    -- cmd = {'/home/edvard/bin/jdt-language-server-latest/bin/jdtls'},
    cmd = {
      vim.g.java_exe,
      '-Declipse.application=org.eclipse.jdt.ls.core.id1',
      '-Dosgi.bundles.defaultStartLevel=4',
      '-Declipse.product=org.eclipse.jdt.ls.core.product',
      '-Dlog.protocol=true',
      '-Dlog.level=ALL',
      '-Xms1g',
      '--add-modules=ALL-SYSTEM',
      '--add-opens', 'java.base/java.util=ALL-UNNAMED',
      '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
      '-jar', vim.g.jdtls_jar,
      '-configuration', vim.g.jdtls_config,
      '-data', '~/java_files'
    },
    root_dir = vim.fs.dirname(vim.fs.find({'.gradlew', '.git', 'mvnw'}, { upward = true })[1]),
    on_attach = on_attach,
    init_options = {
      bundles = bundles
    }
  }
  P(config)
  require('jdtls').start_or_attach(config)
end

return M
