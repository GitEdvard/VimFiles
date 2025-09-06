Plug 'itchyny/lightline.vim'

" Set this to enable lightline
lua vim.opt.laststatus = 2

let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'gitbranch', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'class', 'method', 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \   'gitbranch': 'FugitiveHead',
      \   'class': 'GetClass',
      \   'method': 'GetMethod'
      \ },
      \ 'mode_map': {
        \ 'n' : 'N',
        \ 'i' : 'I',
        \ 'R' : 'R',
        \ 'v' : 'V',
        \ 'V' : 'VL',
        \ "\<C-v>": 'VB',
        \ 'c' : 'C',
        \ 's' : 'S',
        \ 'S' : 'SL',
        \ "\<C-s>": 'SB',
        \ 't': 'T',
        \ },
      \ }

function! LightlineFilename()
    return expand('%')
endfunction

function! GetClass()
    return luaeval("require('python.mypythonlsp').find_current_class_name()")
endfunction

function! GetMethod()
  return luaeval("require('python.mypythonlsp').find_current_method_name()")
endfunction
