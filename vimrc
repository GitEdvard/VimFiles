" https://github.com/tpope/vim-pathogen
execute pathogen#infect()

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
set incsearch
set tabstop=2 shiftwidth=2 expandtab
"Case insensitive search.
set ic
" Set this to enable lightline 
set laststatus=2
" This is handled by lightline
set noshowmode

" https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')

" This is our list of plugins to install
Plug 'mhinz/vim-startify'
Plug 'scrooloose/nerdtree'
Plug 'dyng/ctrlsf.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'vim-scripts/LustyExplorer' 
Plug 'jlanzarotta/bufexplorer'
Plug 'itchyny/lightline.vim'
Plug 'pearofducks/ansible-vim'
Plug 'stephpy/vim-yaml'
call plug#end()

"""
" Basic config setup
"""

" Standard Vim configuration boilerplate
syntax on
filetype plugin indent on
set t_Co=256
set encoding=utf-8
set number

" Bind "jj" to <esc> to jump out of insert mode
inoremap jj <esc>

let mapleader = "\<Space>"

" Custom configuration begins

" With this, you can enter ":Config" in normal mode to open the Vim
" configuration.
command! Config execute ":e $MYVIMRC"

" Call ":Reload" to apply the latest .vimrc contents
command! Reload execute "source ~/.vimrc"
command! Longfile execute ":e ~/sources/test/dotfiles/.vimrc"

" Swap to latest buffer
noremap <leader>o :bp<cr>

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

"""
" ansible-vim
"""
let g:ansible_unindent_after_newline = 1
let g:ansible_name_highlight = 'd'
let g:ansible_extra_keywords_highlight = 1
let g:ansible_extra_keywords_highlight_group = 'Statement'
let g:ansible_normal_keywords_highlight = 'Constant'
let g:ansible_template_syntaxes = { '*.rb.j2': 'ruby' }
let g:ansible_ftdetect_filename_regex = '\v(playbook|site|main|local|requirements)\.ya?ml$'

" vim-plug example
let g:ansible_goto_role_paths = './roles,../_common/roles'

function! FindAnsibleRoleUnderCursor()
  if exists("g:ansible_goto_role_paths")
    let l:role_paths = g:ansible_goto_role_paths
  else
    let l:role_paths = "./roles"
  endif
  let l:tasks_main = expand("<cfile>") . "/tasks/main.yml"
  let l:found_role_path = findfile(l:tasks_main,l:role_paths)
  if l:found_role_path == ""
    echo l:tasks_main . " not found"
  else
    execute "edit " . fnameescape(l:found_role_path)
  endif
endfunction

au BufRead,BufNewFile */system-management/snpseq/*.yml nnoremap <leader>r :call FindAnsibleRoleUnderCursor()<CR>
au BufRead,BufNewFile */system-management/snpseq/*.yml vnoremap <leader>r :call FindAnsibleRoleUnderCursor()<CR>

au BufRead,BufNewFile */miarka-provision/*.yml nnoremap <leader>r :call FindAnsibleRoleUnderCursor()<CR>
au BufRead,BufNewFile */miarka-provision/*.yml vnoremap <leader>r :call FindAnsibleRoleUnderCursor()<CR>
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

" Bind "<leader>b" to show buffers
nmap <leader>b :Buffers!<CR>
" Bind "cc" to a fzf-powered command search
nmap cc :Commands!<CR>

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
nmap <leader>n :call ToggleNERDTree()<CR>

"""
" CtrlSF
"""

" https://github.com/dyng/ctrlsf.vim

" Set "<leader>s" to substitute the word under the cursor. Works great with
" CtrlSF!
nmap <leader>s :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>

" Set up some handy CtrlSF bindings
nmap <leader>a :CtrlSF -R ""<Left>
nmap <leader>A <Plug>CtrlSFCwordPath -W<CR>
nmap <leader>c :CtrlSFFocus<CR>
nmap <leader>C :CtrlSFToggle<CR>

" Use Ripgrep with CtrlSF for performance
let g:ctrlsf_ackprg = '/usr/bin/rg'


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

" https://hisham.hm/htop/
noremap <leader>h :tab term ++close htop<CR>

" https://github.com/jesseduffield/lazygit
noremap <leader>g :tab term ++close lazygit<CR>

" term variants of the tab navigation bindings from above to make the
" interactive command line tools easier to work with
noremap <C-h> :tabp<CR>
noremap - :tabm -1<CR>
noremap <C-l> :tabn<CR>
noremap = :tabm +1<CR>
noremap <C-j> :tabc<CR>
noremap <C-k> :tabe <Bar> Startify<CR>
