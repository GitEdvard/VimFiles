Plug 'mhartington/formatter.nvim/'

augroup formatter-plug-egent
    autocmd!
    autocmd User plug-event lua require'myformatter'
augroup END
