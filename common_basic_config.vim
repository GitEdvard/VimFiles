"---------------------------------------------------
" Basic config
"---------------------------------------------------
filetype plugin indent on
set encoding=utf-8
set hidden
lua vim.opt.syntax = "on"
lua vim.opt.number = true
lua vim.opt.relativenumber = true
set list
set list lcs=trail:·,tab:»·
lua vim.opt.wildmenu = true
lua vim.opt.path:append("**")

" set cursorline
" highlight CursorLine ctermbg=Yellow cterm=bold guibg=#2b2b2b

" let g:airline_powerline_fonts = 1

" Get rid of pesky q:s
" set guicursor=
lua vim.opt.guicursor = ""

lua vim.opt.secure = true

lua vim.opt.incsearch = true
lua vim.opt.ic = true

lua vim.opt.smartcase = true

" colorscheme codedark
" lua vim.opt.background="light"
" colorscheme PaperColor

set tabstop=4 shiftwidth=4 expandtab

hi ctrlsfMatch cterm=NONE ctermfg=black ctermbg=blue

" highlight ExtraWhitespace ctermbg=red guibg=red

" Set wait time between key strokes
set timeoutlen=1000

set nobackup
set nowritebackup
set noswapfile

" Fix zt an zb near edges
set scrolloff=3

" Be kind to ourselves and enable the mouse
if has('mouse')
  set mouse-=a
endif
