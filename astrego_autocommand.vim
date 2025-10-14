function SetFoldsLevel2()
    let s:myvar = &l:foldmethod
    if s:myvar == "manual"
        setlocal foldmethod=indent foldlevel=2
    endif
endfunction

augroup knowledgebase
    autocmd!
    autocmd BufEnter knowledgebase*.py call SetFoldsLevel2()
augroup END

lua require('astrego_autocommands')
