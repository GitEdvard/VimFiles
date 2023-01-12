Plug 'dyng/ctrlsf.vim'

" Use Ripgrep with CtrlSF for performance
let g:ctrlsf_ackprg = '/usr/bin/rg'

nmap <leader>a <Plug>CtrlSFCwordPath -W<CR>:CtrlSFFocus<CR>
nmap <leader>A <Plug>CtrlSFCwordPath
nmap <leader>c :CtrlSFFocus<CR>
nmap <leader>C :CtrlSFToggle<CR>
