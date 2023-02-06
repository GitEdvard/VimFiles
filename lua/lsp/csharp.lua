local M = {}
M.setup = function(lsp_flags, capabilities, on_attach)
  local pid = vim.fn.getpid()
  local omnisharp_bin = "/home/edvard/.cache/omnisharp/OmniSharp"
  -- local omnisharp_bin = "/mnt/c/Users/edeng655/AppData/Local/omnisharp-vim/omnisharp-rosly/OmniSharp.exe"
  require('lspconfig')['omnisharp'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) }
  }
end

return M
