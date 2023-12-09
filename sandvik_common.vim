" https://github.com/tpope/vim-pathogen
execute pathogen#infect()

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

let mapleader = "f"

lua require('globals')
" https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')

source ~/.vim/myplugfiles/nerdtree.vim
source ~/.vim/myplugfiles/ctrlsf.vim
source ~/.vim/myplugfiles/fzf.vim
source ~/.vim/myplugfiles/fugitive.vim
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-entire'
Plug 'gaving/vim-textobj-argument'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
source ~/.vim/myplugfiles/undotree.vim
Plug 'nvim-lua/plenary.nvim'
Plug 'BurntSushi/ripgrep'
source ~/.vim/myplugfiles/telescope.vim
source ~/.vim/myplugfiles/treesitter.vim
source ~/.vim/myplugfiles/lsp.vim
source ~/.vim/myplugfiles/luasnip.vim
source ~/.vim/myplugfiles/debugger-sandvik.vim
Plug 'bps/vim-textobj-python'
Plug 'gpanders/editorconfig.nvim'
Plug 'mfussenegger/nvim-jdtls'
Plug 'sukima/xmledit'
source ~/.vim/myplugfiles/closetag.vim
source ~/.vim/myplugfiles/test-on-save.vim
Plug 'GitEdvard/read-settings.nvim'
source ~/.vim/myplugfiles/trigger-commands.vim
Plug 'tpope/vim-projectionist'
source ~/.vim/myplugfiles/lightline.vim
Plug 'tomasiser/vim-code-dark'
source ~/.vim/myplugfiles/git-worktree.vim
source ~/.vim/myplugfiles/my-hello-telescope.vim
source ~/.vim/myplugfiles/run-configs.vim
source ~/.vim/myplugfiles/formatter.vim

call plug#end()

doautocmd User plug-event

"---------------------------------------------------
" Basic config
"---------------------------------------------------
filetype plugin indent on
set t_Co=256
set encoding=utf-8
set hidden
lua vim.opt.syntax = "on"
lua vim.opt.number = true
lua vim.opt.relativenumber = true
set list
set list lcs=trail:·,tab:»·
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

set tabstop=4 shiftwidth=4

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

"---------------------------------------------------
" Keymaps
"---------------------------------------------------
nnoremap <space> i<space><esc>l
nnoremap s f
nnoremap <c-o> <c-o>zz
nnoremap <c-t> <c-t>zz
nnoremap <c-i> <c-i>zz
nnoremap dd A<bs><esc>
nnoremap <c-g><c-f> <C-w>v<C-w>Tgf
nnoremap gf <C-w>v<C-w>T:e <cfile><CR>
nnoremap fo :!Git add .<cr>
" nnoremap <leader>ut :retab<cr>
nnoremap <leader>J J

" Reload current file
nnoremap <leader>e :e!<CR>
nnoremap <leader>Q :bufdo bdelete<cr>

" easy insertion of ; or , in insert mode
imap ;; <esc>A;<esc>
imap ,, <esc>A,<esc>
inoremap {{ <esc>A {<c-m>}<esc>
inoremap jp <esc>la
inoremap j; ();<esc>
inoremap j, (),
inoremap j. ().
inoremap <c-d> <esc>lxi

" Open current file in a new tab
nnoremap <leader>r <C-w>v<C-w>T
" substitute
nnoremap <leader>v s
" Capitalize word to the left
inoremap jc <esc>bgUllgueea

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
" inoremap { {}<Left>
inoremap <c-f><space> <space><space><Left>

" center screen after search
nnoremap n nzzzv
nnoremap N Nzzzv

nnoremap <c-w><c-o> :tab sp<cr>
" Bind "jk" to <esc> to jump out of insert mode
inoremap jk <esc>
inoremap jl <esc>l

" Swap colon and semicolon
noremap ; :
noremap , ;
" Find next backward
nnoremap <leader>, ,

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

nnoremap <silent> <leader>g :tabe <bar> G<CR> <c-w>o

noremap <C-h> :tabp<CR>
noremap - :tabm -1<CR>
noremap <C-l> :tabn<CR>
noremap = :tabm +1<CR>
noremap <C-j> :tabc<CR> :tabp<CR>
noremap <C-k> :tabe<CR>

nnoremap <leader>q :copen<cr> <c-w>L

" nnoremap <leader>l :let myvar=substitute(expand('%:r'), '/', '.', 'g')<CR> :call vimspector#LaunchWithSettings( #{ CURRENT_PY_PATH: myvar })<CR>

command! Reloadall execute ":bufdo e!"
command! JsonPrettify execute ":r !xclip -selection clipboard -o | jsonlint"
command! Config execute ":e ~/.vimrc"
command! W execute ":w!"
command! E execute ":noautocmd w!"
command! T execute ":w | source %"
command! Reload execute "source ~/myvim/VimRoot/vimrc"
command! Longfile execute ":e ~/sources/test/dotfiles/.vimrc"
command! Gitpush execute ":! git push origin develop"
command! Gitpushforce execute ":! git push -f origin develop"
command! Mksession execute ":mksession!"
command! Ctags execute ":!ctags -R"
command! Ostart execute ":OmniSharpStartServer"
command! Ostop execute ":OmniSharpStopServer"
command! FileHistory execute ":BCommits"
command! ShowAscii execute ":set statusline=%<%f%h%m%r%=%b\ 0x%B\ \ %l,%c%V\ %P"
command! AppendClipboard execute ":!win32yank.exe -o >> %"
command! PurgeWindowEndings execute ":%s/\r/"
command! Glog execute ":Gclog" | call feedkeys("<a-j><c-w>L")
command! Glogg execute ":Gclog -- %" | call feedkeys("<a-j><c-w>L")

function Recordfilepath_internal()
    set cmdheight=2
    redir @a
    let myoutput = feedkeys("1<c-G>")
    redir END
    set cmdheight=1
    return myoutput
endfunction

command! Recordfilepath call Recordfilepath_internal()<cr>

"---------------------------------------------------
" Autocommand autocmd
"---------------------------------------------------
augroup indent2_augroup
    autocmd!
    autocmd FileType json,typescript,text,css,lua,html,xml,jsp setlocal shiftwidth=2 tabstop=2
augroup END

lua require('java.mysandvik_settings')

augroup java_augroup
    autocmd!
    autocmd FileType java lua require('java.mysandvik_settings')
augroup END

" augroup format_java_augroup
"     autocmd!
"     autocmd BufWritePost *.java Format
" augroup END

" augroup FormatAutogroup
"   autocmd!
"   " autocmd User FormatterPre :setlocal autoread
"   autocmd User FormatterPost :e!
" augroup END

augroup expand_tab_augroup
    autocmd!
    autocmd FileType text,json setlocal expandtab
augroup END
