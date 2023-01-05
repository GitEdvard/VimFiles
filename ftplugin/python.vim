setlocal autoindent expandtab tabstop=4 shiftwidth=4 cursorcolumn
nnoremap <leader>j J
nmap J ]pf
nmap K [pf

:set errorformat=%f:%l:\ %m
:set errorformat+=%.%#File\ \"%f\"\\,\ line\ %l\\,\ in\ %m
:set makeprg=pytest
