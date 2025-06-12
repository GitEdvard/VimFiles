" Plug 'C:\Users\yh6032\HOME\git_me\pickers\config-picker'
" Plug 'C:\Users\yh6032\HOME\git_me\pickers\simple-picker'
Plug '/home/edvard/sources/admin/VimPlugins/pickers/simple-picker'

augroup myrun-config-plug-event
    autocmd!
    autocmd User plug-event lua require('myrun_configs_astrego')
augroup END

