local M = {}

local util = require 'lspconfig.util'

M.setup = function(lsp_flags, capabilities, on_attach)
  require('lspconfig')['gopls'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    cmd = { 'gopls' },
    filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
    root_dir = function(fname)
      return util.root_pattern 'go.work'(fname) or util.root_pattern('go.mod', '.git')(fname)
    end,
    single_file_support = true,
    docs = {
      description = [[
  https://github.com/golang/tools/tree/master/gopls

  Google's lsp server for golang.
  ]],
      default_config = {
        root_dir = [[root_pattern("go.mod", ".git")]],
      },
    },
  }
end

return M
