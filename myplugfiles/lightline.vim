Plug 'itchyny/lightline.vim'

" Set this to enable lightline
lua vim.opt.laststatus = 2

let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'gitbranch', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \   'gitbranch': 'FugitiveHead'
      \ }
      \ }

function! LightlineFilename()
    return expand('%')
endfunction

