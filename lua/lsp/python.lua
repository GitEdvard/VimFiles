local M = {}

M.setup = function(lsp_flags, capabilities, on_attach)
  require('lspconfig')['pylsp'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    settings = {
      pylsp = {
        plugins = {
          flake8 = {enabled = false},
          pycodestyle = {enabled = false},
          pyflakes = {enabled = true},
          pylint = {enabled = true},
          mccabe = {enabled = false},
        }
      }
    }
  }
end

return M
