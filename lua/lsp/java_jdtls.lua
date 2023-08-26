local M = {}
local on_attach_base = require'lsp.on_attach'.keymaps
local on_attach = function(client, bufnr)
  on_attach_base(client, bufnr)
  -- With `hotcodereplace = 'auto' the debug adapter will try to apply code changes
  -- you make during a debug session immediately.
  -- Remove the option if you do not want that.
  -- require('jdtls').setup_dap({ hotcodereplace = 'auto' })
end

require('dap.ext.vscode').load_launchjs()
local bundles = {
  -- vim.fn.glob('~/.cache/nvim/com.microsoft.java.debug.plugin-0.44.0.jar')
}
-- I dont think these bundles are really neccesary
-- vim.list_extend(bundles, vim.split(vim.fn.glob("~/.cache/nvim/vscode-java-test/server/*.jar", 1), "\n"))
-- local root_dir = vim.fn.getcwd()
local root_dir = require('jdtls.setup').find_root({'.git' })
-- local root_dir = "C:\\Users\\yh6032\\git\\i290.manufacturing\\i290.manufacturing\\i290.cmm"
local project_name  = vim.fn.fnamemodify(root_dir, ':t')
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
      '-data', vim.g.java_files_base .. "\\" .. project_name
    },
    on_attach = on_attach,
    root_dir = root_dir,
    settings = {
<<<<<<< HEAD
        java = {}
=======
        java = {
            project = {
            }
        }
>>>>>>> bd88fb4 (Save command for root dir in comment)
    },
    init_options = {
      bundles = bundles
    }
 }
  require('jdtls').start_or_attach(config)
end
return M
