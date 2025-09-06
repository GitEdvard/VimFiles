function SetFolds()
    " let s:myvar = "hell0o"
    let s:myvar = &l:foldmethod
    if s:myvar == "manual"
        setlocal foldmethod=indent foldlevel=2
    endif
endfunction

augroup knowledgebase
    autocmd!
    autocmd BufEnter knowledgebase*.py call SetFolds()
augroup END


