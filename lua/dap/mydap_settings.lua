require("dap.common-keymap")
require("dap.read-dapsettings")

require('dapui').setup()
require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
require("nvim-dap-virtual-text").setup()
require('telescope').load_extension('dap')

require'dap'.adapters.coreclr = {
    type = 'executable',
    command = '/home/edvard/.cache/netcoredbg/netcoredbg',
    args = {'--interpreter=vscode'}
}
