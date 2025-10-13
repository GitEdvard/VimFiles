Plug 'stevearc/oil.nvim'

augroup oil-plug-event
    autocmd!
    autocmd User plug-event lua require('oil.myoil_settings')
augroup END
