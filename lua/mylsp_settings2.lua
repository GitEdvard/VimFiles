local pid = vim.fn.getpid()
local omnisharp_bin = "/home/edvard/.cache/omnisharp-vim/omnisharp-roslyn/run"
require('lspconfig')['omnisharp'].setup{
    cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) }
}
