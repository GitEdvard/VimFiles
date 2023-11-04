Plug 'C:\Users\yh6032\HOME\git_me\hello-telescope.nvim'

augroup hello-telescope-plug-event
    autocmd!
    autocmd User plug-event lua require('examples.hello-telescope-settings')
augroup END

