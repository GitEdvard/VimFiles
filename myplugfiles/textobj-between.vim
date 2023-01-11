Plug 'thinca/vim-textobj-between'

let g:textobj_between_no_default_key_mappings=1

augroup textobj-between
    autocmd!
    autocmd User plug-event omap id <Plug>(textobj-between-i)
    autocmd User plug-event omap ad <Plug>(textobj-between-a)
augroup END
