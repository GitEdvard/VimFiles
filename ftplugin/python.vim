setlocal foldmethod=indent foldnestmax=2 autoindent expandtab tabstop=4 shiftwidth=4 cursorcolumn
execute 'normal! zR'
nnoremap <leader>j J
nmap J ]pf
nmap K [pf

:set errorformat=%f:%l:\ %m
:set makeprg=pytest
