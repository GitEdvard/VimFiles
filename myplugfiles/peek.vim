Plug 'toppair/peek.nvim', { 'do': 'deno task --quiet build:fast' }

augroup peek-plug-event
    autocmd!
    autocmd User plug-event lua require('peek.mypeeksettings')
augroup END
