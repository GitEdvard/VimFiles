" Plug '/home/edvard/sources/admin/VimPlugins/trigger-commands.nvim'
" Plug 'GitEdvard/trigger-commands.nvim'
Plug 'C:\Users\yh6032\HOME\myvim\trigger-commands.nvim'

augroup trigger-commands-plug-event
    autocmd!
    autocmd User plug-event lua require('mytriggercommands')
augroup END
