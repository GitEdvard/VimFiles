Plug 'dyng/ctrlsf.vim'

" Use Ripgrep with CtrlSF for performance
let g:ctrlsf_ackprg = '/usr/bin/rg'

augroup ctrlsf-event
    autocmd!
    autocmd User plug-event nmap <leader>a <Plug>CtrlSFCwordPath -W<CR>:CtrlSFFocus<CR>
    autocmd User plug-event nmap <leader>A <Plug>CtrlSFCwordPath
    autocmd User plug-event nmap <leader>c :CtrlSFFocus<CR>
    autocmd User plug-event nmap <leader>C :CtrlSFToggle<CR>
augroup END
