" Plug 'toppair/peek.nvim', { 'do': 'deno task --quiet build:fast' }
Plug 'toppair/peek.nvim'

augroup peek-plug-event
    autocmd!
    autocmd User plug-event lua require('peek.mypeeksettings')
augroup END
