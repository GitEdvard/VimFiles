Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'mfussenegger/nvim-dap-python'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'nvim-telescope/telescope-dap.nvim'

augroup dap-plug-event
    autocmd!
    autocmd User plug-event lua require('dap.mydap_settings')
augroup END
