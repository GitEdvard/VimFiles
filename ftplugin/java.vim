function! StartJavaLsp()
    lua require'lsp.java_jdtls'.setup()
endfunction
" execute StartJavaLsp()
set errorformat=\[ERROR\]\ %f:\[%l\\\,%c\]\ %m
set errorformat+=%.%#att\ %f\(%l\)
set errorformat+=%.%#at\ %.%#\(%f:%l\)
set errorformat+=at\ %f\ \(%l\)
set errorformat+=%.%#\[javac\]%[0-9.]%#\ %m\ in\ %f\ \(at\ line\ %l\)%.%#
nnoremap <leader>j J
nnoremap J j]mk
nnoremap K [mk
