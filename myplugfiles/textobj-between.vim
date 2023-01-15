Plug 'thinca/vim-textobj-between'

let g:textobj_between_no_default_key_mappings=1

augroup between-plug-event
    autocmd!
    autocmd User plug-event omap ad <Plug>(textobj-between-a)
    autocmd User plug-event omap id <Plug>(textobj-between-i)
augroup END
