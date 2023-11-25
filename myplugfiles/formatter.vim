Plug 'mhartington/formatter.nvim'
" Plug 'GitEdvard/formatter.nvim'
" Plug 'C:\Users\yh6032\HOME\git_me\formatter.nvim'


augroup formatter-plug-egent
    autocmd!
    autocmd User plug-event lua require'myformatter'
augroup END
