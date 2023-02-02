" https://github.com/tpope/vim-pathogen
execute pathogen#infect()

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

let mapleader = "\<Space>"

lua require('globals')
" https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')

source ~/.vim/myplugfiles/base16-vim.vim
source ~/.vim/myplugfiles/ansible-vim.vim
Plug 'mhinz/vim-startify'
source ~/.vim/myplugfiles/nerdtree.vim
source ~/.vim/myplugfiles/ctrlsf.vim
source ~/.vim/myplugfiles/fzf.vim
Plug 'stephpy/vim-yaml'
Plug 'kdheepak/lazygit.nvim'
source ~/.vim/myplugfiles/fugitive.vim
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'RRethy/vim-illuminate'
Plug 'patstockwell/vim-monokai-tasty'
Plug 'tomasiser/vim-code-dark'
" source ~/.vim/myplugfiles/ultisnips.vim
" Plug 'honza/vim-snippets'
source ~/.vim/myplugfiles/taglist.vim
Plug 'michaeljsmith/vim-indent-object'
Plug 'rhysd/vim-textobj-anyblock'
Plug 'kana/vim-textobj-user'
Plug 'bps/vim-textobj-python'
source ~/.vim/myplugfiles/textobj-between.vim
Plug 'glts/vim-textobj-comment'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-entire'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'gaving/vim-textobj-argument'
source ~/.vim/myplugfiles/vimtest.vim
Plug 'tpope/vim-dispatch'
Plug 'mbbill/undotree'
source ~/.vim/myplugfiles/markdown-preview.vim
" stackmap, for switch mappings in quickfix window
Plug 'tjdevries/stackmap.nvim'

" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'BurntSushi/ripgrep'
source ~/.vim/myplugfiles/telescope.vim
source ~/.vim/myplugfiles/treesitter.vim
" Plug 'puremourning/vimspector'
source ~/.vim/myplugfiles/debugger.vim

source ~/.vim/myplugfiles/lsp.vim
source ~/.vim/myplugfiles/luasnip.vim

" csharp things
" Plug 'OmniSharp/omnisharp-vim'
let g:OmniSharp_loglevel = "debug"
Plug 'gpanders/editorconfig.nvim'

" Plug 'ionide/Ionide-vim'
" My plugins
source ~/.vim/myplugfiles/test-on-save.vim
Plug '/home/edvard/sources/admin/VimPlugins/read-settings.nvim'
source ~/.vim/myplugfiles/trigger-commands.vim
Plug 'tpope/vim-projectionist'

" Experimental
" https://www.youtube.com/watch?v=434tljD-5C8
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
source ~/.vim/myplugfiles/lightline.vim
Plug 'whatyouhide/vim-textobj-xmlattr'
call plug#end()

doautocmd User plug-event

"---------------------------------------------------
" Basic config
"---------------------------------------------------
abbr _bash #! /bin/bash<CR>
filetype plugin indent on
set t_Co=256
set encoding=utf-8
set hidden
lua vim.opt.syntax = "on"
lua vim.opt.number = true
lua vim.opt.relativenumber = true
set list
set listchars:trail:.
lua vim.opt.wildmenu = true
lua vim.opt.path:append("**")

" let g:airline_powerline_fonts = 1

" Get rid of pesky q:s
" set guicursor=
lua vim.opt.guicursor = ""

lua vim.opt.secure = true

lua vim.opt.incsearch = true
lua vim.opt.ic = true

lua vim.opt.smartcase = true

lua vim.opt.termguicolors = true

lua vim.opt.bg = dark
colorscheme codedark

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

let g:python3_host_prog = '/home/edvard/.virtualenvs/pynvim/bin/python3'
"---------------------------------------------------
" Keymaps
"---------------------------------------------------
nnoremap gf <C-w>v<C-w>T:e <cfile><CR>

nnoremap <leader>k :UndotreeShow<cr> :UndotreeFocus<cr>
" Reload current file
nnoremap <leader>e :e!<CR>
nnoremap <leader>Q :bufdo bdelete<cr>

" easy insertion of ; or , in insert mode
imap ;; <esc>A;<esc>
imap ,, <esc>A,<esc>

" Open current file in a new tab
nnoremap <leader>r <C-w>v<C-w>T

" Automatic indentation
nnoremap <leader>= =

" open file with default program
nnoremap <leader>x :!xdg-open %<cr>

nnoremap <c-d> <c-d>zz
nnoremap <c-u> <c-u>zz

set cursorline

highlight CursorLine ctermbg=Yellow cterm=bold guibg=#2b2b2b

" Retain selection when indenting blocks
vmap > >gv
vmap < <gv
" Time in milliseconds (default 0)
let g:Illuminate_delay = 700

" Center screen when inserting
nnoremap i zzi
nnoremap o zzo
nnoremap O zzO

" Matching paranthesis etc.
inoremap " ""<Left>
inoremap ' ''<Left>
inoremap [ []<Left>
inoremap ( ()<Left>
inoremap { {}<Left>

" center screen after search
nnoremap n nzzzv
nnoremap N Nzzzv

nnoremap <c-w><c-o> :tab sp<cr>
" Bind "jk" to <esc> to jump out of insert mode
inoremap jk <esc>

" Swap colon and semicolon
noremap ; :
noremap , ;

function DeleteHiddenBuffers()
    let tpbl=[]
    call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
    for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
        silent execute 'bwipeout' buf
    endfor
endfunction
nmap <leader>D :call DeleteHiddenBuffers()<CR>

" Copy to system clipboard
vmap <leader>c "+y
" Quickly get rid of highlighting
noremap <leader>h :noh<CR>

" Simple tab navigation with <C-h> and <C-l> to intuitively go left and right
noremap <C-h> :tabp<CR>
noremap <C-l> :tabn<CR>

" Move between windows in same tab
noremap <A-l> <c-w>l
noremap <A-h> <c-w>h
noremap <A-j> <c-w>j
noremap <A-k> <c-w>k

nmap <leader>s :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>

" Resize with arrows
noremap <c-Up> :resize -2<cr>
noremap <c-Down> :resize +2<cr>
noremap <c-Left> :vertical resize -2<cr>
noremap <c-Right> :vertical resize +2<cr>

nnoremap <silent> <leader>g :LazyGit<CR>

noremap <C-h> :tabp<CR>
noremap - :tabm -1<CR>
noremap <C-l> :tabn<CR>
noremap = :tabm +1<CR>
noremap <C-j> :tabc<CR> :tabp<CR>
noremap <C-k> :tabe <Bar> Startify<CR>

nnoremap <leader>q :copen<cr> <c-w>L

" nnoremap <leader>l :let myvar=substitute(expand('%:r'), '/', '.', 'g')<CR> :call vimspector#LaunchWithSettings( #{ CURRENT_PY_PATH: myvar })<CR>

command! Reloadall execute ":bufdo e!"
command! JsonPrettify execute ":r !xclip -selection clipboard -o | jsonlint"
command! Config execute ":e ~/.vimrc"
command! W execute ":w | source %"
command! Reload execute "source ~/.vimrc"
command! Longfile execute ":e ~/sources/test/dotfiles/.vimrc"
command! Gitpush execute ":! git push origin develop"
command! Gitpushforce execute ":! git push -f origin develop"
command! Mksession execute ":mksession!"
command! Ctags execute ":!ctags -R"
command! Ostart execute ":OmniSharpStartServer"
command! Ostop execute ":OmniSharpStopServer"
command! FileHistory execute ":BCommits"

"---------------------------------------------------
" Autocommand autocmd
"---------------------------------------------------
augroup indent2_augroup
    autocmd!
    autocmd FileType json,typescript,text,css,lua,html setlocal shiftwidth=2 tabstop=2
augroup END

augroup illuminate_augroup
    autocmd!
    autocmd VimEnter * hi link illuminatedWord CursorLine
augroup END

augroup ansible_augroup
    autocmd!
    autocmd FileType yaml setlocal autoindent expandtab tabstop=2 shiftwidth=2 cursorcolumn
augroup END

" Workaround some broken plugins which set guicursor indiscriminately.
autocmd OptionSet guicursor noautocmd set guicursor=


function! Tig()
  !tig status
  redraw!
endfunction
