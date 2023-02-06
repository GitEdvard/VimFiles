local M = {}

M.setup = function(lsp_flags, capabilities, on_attach)
  require('lspconfig')['pyright'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities
  }
end

return M
