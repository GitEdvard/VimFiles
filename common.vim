" https://github.com/tpope/vim-pathogen
execute pathogen#infect()

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" lua require('ensure_packer')
" lua require('plugins')

" https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')

" This is our list of plugins to install
" Plug 'chriskempson/base16-vim'
source ~/.vim/myplugfiles/base16-vim.vim
source ~/.vim/myplugfiles/ansible-vim.vim
Plug 'mhinz/vim-startify'
source ~/.vim/myplugfiles/nerdtree.vim
source ~/.vim/myplugfiles/ctrlsf.vim
source ~/.vim/myplugfiles/fzf.vim
Plug 'jlanzarotta/bufexplorer'
source ~/.vim/myplugfiles/lightline.vim
Plug 'stephpy/vim-yaml'
Plug 'kdheepak/lazygit.nvim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'ntpeters/vim-better-whitespace'
Plug 'RRethy/vim-illuminate'
Plug 'patstockwell/vim-monokai-tasty'
Plug 'tomasiser/vim-code-dark'
Plug 'Yilin-Yang/vim-markbar'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
source ~/.vim/myplugfiles/taglist.vim
Plug 'michaeljsmith/vim-indent-object'
Plug 'rhysd/vim-textobj-anyblock'
Plug 'kana/vim-textobj-user'
Plug 'bps/vim-textobj-python'
source ~/.vim/myplugfiles/textobj-between.vim
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-entire'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'gaving/vim-textobj-argument'
Plug 'vim-test/vim-test'
Plug 'tpope/vim-dispatch'
Plug 'mbbill/undotree'
" stackmap, for switch mappings in quickfix window
Plug 'tjdevries/stackmap.nvim'

" Debugger
Plug 'puremourning/vimspector'
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'mfussenegger/nvim-dap-python'
Plug 'theHamsta/nvim-dap-virtual-text'

" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'BurntSushi/ripgrep'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'nvim-telescope/telescope-file-browser.nvim'
" Note!!!! Go to directory where telescope-fzf-native is installed, and run
" make clean && make
" will take care of E5108: Error executing lua  'fzf' extension doesn't exist
" or isn't installed"
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
Plug 'nvim-telescope/telescope-dap.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

" Language server support
Plug 'neovim/nvim-lspconfig'
Plug 'mfussenegger/nvim-lint'

" Autocompletion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer', {'do': 'make'}
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-path'
" Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'onsails/lspkind.nvim'

" csharp things
Plug 'OmniSharp/omnisharp-vim'
Plug 'gpanders/editorconfig.nvim'

" My plugins
Plug '/home/edvard/sources/admin/VimPlugins/test-on-save.nvim'
Plug '/home/edvard/sources/admin/VimPlugins/read-settings.nvim'
Plug '/home/edvard/sources/admin/VimPlugins/trigger-commands.nvim'

call plug#end()

let mapleader = "\<Space>"
doautocmd User plug-event

"---------------------------------------------------
" Basic config
"---------------------------------------------------
abbr _bash #! /bin/bash<CR>
filetype plugin indent on
set t_Co=256
set encoding=utf-8

lua vim.opt.syntax = "on"
lua vim.opt.number = true
lua vim.opt.relativenumber = true

lua vim.opt.wildmenu = true
lua vim.opt.path:append("**")

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

highlight ExtraWhitespace ctermbg=red guibg=red

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
nnoremap gf <C-w>v<C-w>T:e <cfile><CR>

nnoremap <leader>k :UndotreeShow<cr> :UndotreeFocus<cr>
" Reload current file
nnoremap <leader>e :e!<CR>


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
inoremap <c-f>" ""<Left>
inoremap <c-f>' ''<Left>
inoremap <c-f>[ []<Left>
inoremap <c-f>( ()<Left>
inoremap <c-f>{ {}<Left>

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
nmap BD :call DeleteHiddenBuffers()<CR>

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
augroup json_augroup
    autocmd!
    autocmd FileType json setlocal shiftwidth=2 tabstop=2
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

" Open role under cursor. First open current buffer in a new tab.
" snpseq ansible stuff
au BufRead,BufNewFile */system-management/snpseq/*.yml nnoremap <leader>r <C-w>v<C-w>T:call FindAnsibleRoleUnderCursor()<CR>
au BufRead,BufNewFile */system-management/snpseq/*.yml vnoremap <leader>r <C-w>v<C-w>T:call FindAnsibleRoleUnderCursor()<CR>

au BufRead,BufNewFile */miarka-provision/*.yml nnoremap <leader>r <C-w>v<C-w>T:call FindAnsibleRoleUnderCursor()<CR>
au BufRead,BufNewFile */miarka-provision/*.yml vnoremap <leader>r <C-w>v<C-w>T:call FindAnsibleRoleUnderCursor()<CR>

au BufRead,BufNewFile */ansible/*.yml nnoremap <leader>r <C-w>v<C-w>T:call FindAnsibleRoleUnderCursor()<CR>
au BufRead,BufNewFile */ansible/*.yml vnoremap <leader>r <C-w>v<C-w>T:call FindAnsibleRoleUnderCursor()<CR>


function! Tig()
  !tig status
  redraw!
endfunction

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
" nnoremap <leader>l :!export $CURRENT_PY_PATH=substitute(expand('%:r'), '/', '.', 'g')<CR> :echo $CURRENT_PY_PATH<cr>
nnoremap <leader>l :let myvar=substitute(expand('%:r'), '/', '.', 'g')<CR> :call vimspector#LaunchWithSettings( #{ CURRENT_PY_PATH: myvar })<CR>

" source ~/.vim/myscripts/vimspector_settings.vim

lua require('mydap_settings')

""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-test
""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ta :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tv :TestVisit<CR>

let test#python#runner = 'pytest'
let test#csharp#runner = 'dotnettest'
let test#strategy = "make"

" Open qickfix window
" I have this last, the mapping disappears for some reason otherwise
nnoremap <leader>q :copen<cr> <c-w>L

""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Lsp
""""""""""""""""""""""""""""""""""""""""""""""""""""""
set completeopt=menu,menuone,noselect
" let g:OmniSharp_translate_cygwin_wsl = 1

lua require('mylsp_settings')

""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Telescope
""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua require('mytelescope')

""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua require('mytreesitter')
lua require('globals')
lua require('mytriggercommands')

nnoremap <leader>tt :AttachTestMethod<cr>
nnoremap <leader>tc :AttachTestClass<cr>
lua vim.keymap.set('n', '<leader>tr', function() vim.api.nvim_clear_autocmds({ group = "edvard-automagic" }) end, {noremap = true, silent = true})
let g:python3_host_prog = '/home/edvard/.virtualenvs/pynvim/bin/python3'
