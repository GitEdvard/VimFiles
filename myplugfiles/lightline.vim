Plug 'itchyny/lightline.vim'

" Set this to enable lightline
lua vim.opt.laststatus = 2

let g:lightline = {
      \ 'component_function': {
      \   'filename': 'LightlineFilename'
      \ }
      \ }
function! LightlineFilename()
    return expand('%')
endfunction

