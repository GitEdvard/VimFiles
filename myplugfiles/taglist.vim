Plug 'vim-scripts/taglist.vim'

let g:Tlist_WinWidth=50
let Tlist_Close_On_Select = 1

augroup taglist-plug-event
    autocmd!
    autocmd User plug-event nmap <leader>m :TlistOpen<CR>
augroup END
