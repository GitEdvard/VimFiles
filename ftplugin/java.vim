lua require'lsp.java_jdtls'.setup()
set errorformat=\[ERROR\]\ %f:\[%l\\\,%c\]\ %m
set errorformat+=%.%#at\ %.%#\(%f:%l\)
set errorformat+=%DEntering\:\ %f
" set errorformat+=%.%#%XExiting
nnoremap <leader>j J
nnoremap J j]mk
nnoremap K [mk
