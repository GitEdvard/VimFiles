Plug 'tpope/vim-fugitive'

nnoremap <leader>od :Gvdiffsplit<cr>
nnoremap <leader>or :Gread<cr>
nnoremap <leader>ot :Git difftool<cr> <c-w>j<c-w>L
nnoremap <leader>oo :diffoff<cr> <bar> :clo<cr>
