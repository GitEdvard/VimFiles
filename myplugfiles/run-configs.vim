Plug 'C:\Users\yh6032\HOME\git_me\run-configs'

augroup myrun-config-plug-event
    autocmd!
    autocmd User plug-event lua require('myrun_configs')
augroup END

