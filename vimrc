" https://github.com/tpope/vim-pathogen
execute pathogen#infect()

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')

" This is our list of plugins to install
Plug 'chriskempson/base16-vim'
Plug 'mhinz/vim-startify'
Plug 'scrooloose/nerdtree'
Plug 'dyng/ctrlsf.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'jlanzarotta/bufexplorer'
Plug 'itchyny/lightline.vim'
Plug 'pearofducks/ansible-vim'
Plug 'stephpy/vim-yaml'
Plug 'kdheepak/lazygit.nvim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'ntpeters/vim-better-whitespace'
Plug 'RRethy/vim-illuminate'
Plug 'patstockwell/vim-monokai-tasty'
Plug 'tomasiser/vim-code-dark'
Plug 'Yilin-Yang/vim-markbar'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'vim-scripts/taglist.vim'
" Debugger
Plug 'puremourning/vimspector'
" To be able to copy current line with yil
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
"""
Plug 'tpope/vim-commentary'

" To install language servers, manually run:
"   :call InstallCocPlugins()
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
call plug#end()

"""
" Basic config setup
"""

" Standard Vim configuration boilerplate
syntax on
filetype plugin indent on
set t_Co=256
set encoding=utf-8
set number relativenumber

" To install language servers, manually run:
"   :call InstallCocPlugins()
function InstallCocPlugins()
  CocInstall coc-pyright
  source ~/.vim/myscripts/coc-settings.vim
endfunction
command! InstallCocPlugins execute ":call InstallCocPlugins()"

" Get rid of pesky q:s
set guicursor=
" Workaround some broken plugins which set guicursor indiscriminately.
autocmd OptionSet guicursor noautocmd set guicursor=

" https://github.com/neoclide/coc.nvim/issues/3312
autocmd VimLeavePre * if get(g:, 'coc_process_pid', 0)
  \	| call system('kill -9 '.g:coc_process_pid) | endif

" Make OS X play nicely with Vim
" (Doesn't seem to work)
set clipboard=unnamed

" http://damien.lespiau.name/blog/2009/03/18/per-project-vimrc/comment-page-1/
" set exrc " enable per-directory .vimrc files
set secure " disable unsafe commands in local .vimrc files

""""
" Custom configuration begins
""""
abbr _bash #! /bin/bash<CR>

" Autofill matching paranthesis, citations, etc.
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap { {}<left>

set incsearch
"Case insensitive search.
set ic
" Smart case searches
set smartcase
" Set this to enable lightline
set laststatus=2
" This is handled by lightline
set noshowmode

set termguicolors
" colorscheme vim-monokai-tasty
" colorscheme peachpuff
set bg=dark
colorscheme codedark

let mapleader = "\<Space>"

set tabstop=4 shiftwidth=4 expandtab
autocmd FileType yaml setlocal autoindent expandtab tabstop=2 shiftwidth=2 cursorcolumn

" Open files in a new tab
nnoremap gf <C-w>v<C-w>Tgf

" Open files in same tab
nnoremap <leader>gf gf

" Delete rest of the line
nnoremap <leader>d d$

" Reload current file
nnoremap <leader>e :e!<CR>

" Reload all buffers
command! Reloadall execute ":bufdo e!"

" Open current file in a new tab
nnoremap <leader>t <C-w>v<C-w>T

set cursorline

augroup illuminate_augroup
    autocmd!
    autocmd VimEnter * hi link illuminatedWord CursorLine
augroup END

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

" center screen after search
nnoremap n nzzzv
nnoremap N Nzzzv

" Bind "jj" to <esc> to jump out of insert mode
inoremap jj <esc>

" Swap colon and semicolon
noremap ; :
noremap , ;

" Delete buffers
function DeleteHiddenBuffers()
    let tpbl=[]
    call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
    for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
        silent execute 'bwipeout' buf
    endfor
endfunction
nmap BD :call DeleteHiddenBuffers()<CR>
" nmap BD :Bdelete hidden<CR>

" Format selected code.
xmap <leader>b  <Plug>(coc-format-selected)

"hi Search cterm=NONE ctermfg=grey ctermbg=blue

hi ctrlsfMatch cterm=NONE ctermfg=black ctermbg=blue

" show hidden     whitespace
highlight ExtraWhitespace ctermbg=red guibg=red

" Highlight self keyword in python
:syn keyword pythonBuiltin self

" Copy to system clipboard
vmap <leader>c "+y
" Quickly get rid of highlighting
noremap <leader>h :noh<CR>

" Fix zt an zb near edges
set scrolloff=3

" Insert new lines without exit normal mode
nmap oo o<esc>k
nmap OO O<esc>j

" Set wait time between key strokes
set timeoutlen=500

" Prettify json
" --- backup and swap files ---
" I save all the time, those are annoying and unnecessary...
set nobackup
set nowritebackup
set noswapfile

command! JsonPrettify execute ":r !xclip -selection clipboard -o | jsonlint"

" With this, you can enter ":Config" in normal mode to open the Vim
" configuration.
" command! Config execute ":e $MYVIMRC"
command! Config execute ":e ~/.vimrc"

" Call ":Reload" to apply the latest .vimrc contents
command! Reload execute "source ~/.vimrc"
command! Longfile execute ":e ~/sources/test/dotfiles/.vimrc"
command! Gitpush execute ":! git push origin develop"
command! Gitpushforce execute ":! git push -f origin develop"
command! Mksession execute ":mksession!"
command! Ctags execute ":!ctags -R"

" Simple tab navigation with <C-h> and <C-l> to intuitively go left and right
noremap <C-h> :tabp<CR>
noremap <C-l> :tabn<CR>

" Close the tab with <C-j>
noremap <C-J> :tabc<CR>

" Be kind to ourselves and enable the mouse
" Updated by EE, add '-' to prevent visual mode on selection
if has('mouse')
  set mouse-=a
endif

let g:lightline = {
      \ 'component_function': {
      \   'filename': 'LightlineFilename'
      \ }
      \ }
function! LightlineFilename()
    return expand('%')
endfunction

"""
" ansible-vim
"""
source ~/.vim/myscripts/find_ansible_role.vim
let g:ansible_unindent_after_newline = 1
let g:ansible_name_highlight = 'd'
let g:ansible_extra_keywords_highlight = 1
let g:ansible_extra_keywords_highlight_group = 'Statement'
let g:ansible_normal_keywords_highlight = 'Constant'
let g:ansible_template_syntaxes = { '*.rb.j2': 'ruby' }
let g:ansible_ftdetect_filename_regex = '\v(playbook|site|main|local|requirements)\.ya?ml$'

" Open role under cursor. First open current buffer in a new tab.
au BufRead,BufNewFile */system-management/snpseq/*.yml nnoremap <leader>r <C-w>v<C-w>T:call FindAnsibleRoleUnderCursor()<CR>
au BufRead,BufNewFile */system-management/snpseq/*.yml vnoremap <leader>r <C-w>v<C-w>T:call FindAnsibleRoleUnderCursor()<CR>

au BufRead,BufNewFile */miarka-provision/*.yml nnoremap <leader>r <C-w>v<C-w>T:call FindAnsibleRoleUnderCursor()<CR>
au BufRead,BufNewFile */miarka-provision/*.yml vnoremap <leader>r <C-w>v<C-w>T:call FindAnsibleRoleUnderCursor()<CR>

au BufRead,BufNewFile */ansible/*.yml nnoremap <leader>r <C-w>v<C-w>T:call FindAnsibleRoleUnderCursor()<CR>
au BufRead,BufNewFile */ansible/*.yml vnoremap <leader>r <C-w>v<C-w>T:call FindAnsibleRoleUnderCursor()<CR>
"""
" FZF
"""

" https://github.com/junegunn/fzf.vim

" Let The :Files command show all files in the repo (including dotfiles)
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --glob "!.git/*"'

" Bind "//" to a fzf-powered buffer search
nmap // :BLines!<CR>

" Bind "??" to a fzf-powered project search
nmap ?? :Rg!<CR>

" Bind "<leader>p" to a fzf-powered filename search
nmap <leader>p :Files!<CR>

" Bind "<leader>b" to show buffers with contents
nmap <leader>b :Buffers!<CR>

" Bind "<leader>bb" to show buffers without contents
nmap <leader>bb :call fzf#vim#buffers()<CR>

" Bind "cc" to a fzf-powered command search
nmap cc :Commands!<CR>

" Shows Git history for the current buffer
command! FileHistory execute ":BCommits"

" Close other windows
nmap <leader>q <C-w>o

"""
" NERDTree
"""

let NERDTreeShowHidden=1

function! ToggleNERDTree()
  NERDTreeToggle
  " Set NERDTree instances to be mirrored
  silent NERDTreeMirror
endfunction

" Bind "<leader>n" to toggle NERDTree
nmap <leader>n :NERDTreeFind<CR>
au FileType nerdtree vert resize 50
" let g:NERDTreeWinSize=50
let NERDTreeIgnore = ['\.pyc$']

""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Taglist
""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>m :TlistOpen<CR>
let g:Tlist_WinWidth=50

"""
" CtrlSF
"""

" https://github.com/dyng/ctrlsf.vim

" Set "<leader>s" to substitute the word under the cursor. Works great with
" CtrlSF!
nmap <leader>s :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>

" Set up some handy CtrlSF bindings
"nmap <leader>a :CtrlSF -R ""<Left>
nmap <leader>a <Plug>CtrlSFCwordPath -W<CR>:CtrlSFFocus<CR>
nmap <leader>A <Plug>CtrlSFCwordPath

nmap <leader>c :CtrlSFFocus<CR>
nmap <leader>C :CtrlSFToggle<CR>

" Use Ripgrep with CtrlSF for performance
let g:ctrlsf_ackprg = '/usr/bin/rg'

function! Tig()
  !tig status
  redraw!
endfunction

" git commands
nnoremap <silent> <leader>gg :LazyGit<CR>
nnoremap <silent> <leader>gt :call Tig()<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" snippets
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BONUS SECTION!
"
" You can easily open external interactive command line tools from within Vim.
" This isn't for everyone, but it's a convenient way to quickly open a non-Vim
" tool that you frequently use briefly. These examples open htop or lazygit in
" a Vim term tab.  As soon as the interactive tool's session exits, the term
" tab is closed.
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" term variants of the tab navigation bindings from above to make the
" interactive command line tools easier to work with
noremap <C-h> :tabp<CR>
noremap - :tabm -1<CR>
noremap <C-l> :tabn<CR>
noremap = :tabm +1<CR>
noremap <C-j> :tabc<CR> :tabp<CR>
noremap <C-k> :tabe <Bar> Startify<CR>

" Vimspector, debugger
nnoremap <Leader>dd :let $CURRENT_PY_PATH=substitute(expand('%:r'), '/', '.', 'g')<CR> :call vimspector#Launch()<CR>
nnoremap <Leader>de :call vimspector#Reset()<CR>
nnoremap <Leader>dc :call vimspector#Continue()<CR>

nnoremap <Leader>dt :call vimspector#ToggleBreakpoint()<CR>
nnoremap <Leader>dT :call vimspector#ClearBreakpoints()<CR>

nmap <Leader>dk <Plug>VimspectorRestart
nmap <Leader>dh <Plug>VimspectorStepOut
nmap <Leader>dl <Plug>VimspectorStepInto
nmap <Leader>dj <Plug>VimspectorStepOver
