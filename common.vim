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
Plug 'chriskempson/base16-vim'
Plug 'mhinz/vim-startify'
Plug 'preservim/nerdtree'
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
Plug 'tpope/vim-repeat'
Plug 'ntpeters/vim-better-whitespace'
Plug 'RRethy/vim-illuminate'
Plug 'patstockwell/vim-monokai-tasty'
Plug 'tomasiser/vim-code-dark'
Plug 'Yilin-Yang/vim-markbar'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'vim-scripts/taglist.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'rhysd/vim-textobj-anyblock'
Plug 'kana/vim-textobj-user'
Plug 'bps/vim-textobj-python'
Plug 'thinca/vim-textobj-between'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-entire'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'gaving/vim-textobj-argument'
Plug 'vim-test/vim-test'
Plug 'tpope/vim-dispatch'
" stackmap, for switch mappings in quickfix window
Plug 'tjdevries/stackmap.nvim'

" Debugger
Plug 'puremourning/vimspector'

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
Plug 'nvim-treesitter/nvim-treesitter'

" Language server support
Plug 'neovim/nvim-lspconfig'

" Autocompletion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer', {'do': 'make'}
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'

" csharp things
Plug 'OmniSharp/omnisharp-vim'

" To install language servers, manually run:
"   :call InstallCocPlugins()
" Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
call plug#end()

"""
" Basic config setup
"""

" Standard Vim configuration boilerplate
" syntax on
filetype plugin indent on
set t_Co=256
set encoding=utf-8
" set number relativenumber

lua vim.opt.syntax = "on"
lua vim.opt.number = true
lua vim.opt.relativenumber = true
" finding files

lua vim.opt.wildmenu = true
lua vim.opt.path:append("**")
" set path+=**
" set wildmenu

" To install language servers, manually run:
"   :call InstallCocPlugins()
function InstallCocPlugins()
  CocInstall coc-pyright
  source ~/.vim/myscripts/coc-settings.vim
endfunction
command! InstallCocPlugins execute ":call InstallCocPlugins()"

" Get rid of pesky q:s
" set guicursor=
lua vim.opt.guicursor = ""
" Workaround some broken plugins which set guicursor indiscriminately.
autocmd OptionSet guicursor noautocmd set guicursor=

" https://github.com/neoclide/coc.nvim/issues/3312
autocmd VimLeavePre * if get(g:, 'coc_process_pid', 0)
  \	| call system('kill -9 '.g:coc_process_pid) | endif

" Make OS X play nicely with Vim
" (Doesn't seem to work)
" set clipboard=unnamedplus

" http://damien.lespiau.name/blog/2009/03/18/per-project-vimrc/comment-page-1/
" set exrc " enable per-directory .vimrc files
" set secure " disable unsafe commands in local .vimrc files

lua vim.opt.secure = true
""""
" Custom configuration begins
""""
abbr _bash #! /bin/bash<CR>

" set incsearch
lua vim.opt.incsearch = true
"Case insensitive search.
" set ic
lua vim.opt.ic = true

" Smart case searches
" set smartcase
lua vim.opt.smartcase = true

" Set this to enable lightline
" set laststatus=2
lua vim.opt.laststatus = 2

" This is handled by lightline
" set noshowmode
" lua vim.opt.noshowmode = true

" set termguicolors
lua vim.opt.termguicolors = true

" colorscheme vim-monokai-tasty
" colorscheme peachpuff
" set bg=dark
lua vim.opt.bg = dark
colorscheme codedark

let mapleader = "\<Space>"

set tabstop=4 shiftwidth=4 expandtab
autocmd FileType yaml setlocal autoindent expandtab tabstop=2 shiftwidth=2 cursorcolumn

" Open files in a new tab
nnoremap gf <C-w>v<C-w>Tgf

" Open files in same tab
nnoremap <leader>gf gf

" Reload current file
nnoremap <leader>e :e!<CR>

" Reload all buffers
command! Reloadall execute ":bufdo e!"

" Open current file in a new tab
nnoremap <leader>t <C-w>v<C-w>T

" Automatic indentation
nnoremap <leader>= =

set cursorline

augroup illuminate_augroup
    autocmd!
    autocmd VimEnter * hi link illuminatedWord CursorLine
augroup END

" augroup my_quickfix_augroup
"     autocmd!
"     autocmd BufEnter * if &buftype == "quickfix" | stackmap.push("myquckfix", "n" {
"             ["<c-k>"] = "echo 'up'",
"             ["<c-j"] = "echo 'down'"
"         } | endif
"     autocmd BufLeave * if &buftype == 'quickfix' | echo "bye" | endif
" augroup END

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

" Bind "jk" to <esc> to jump out of insert mode
inoremap jk <esc>

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

" Set wait time between key strokes
set timeoutlen=1000

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

command! Ostart execute ":OmniSharpStartServer"
command! Ostop execute ":OmniSharpStopServer"

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

" Move between windows in same tab
noremap <A-l> <c-w>l
noremap <A-h> <c-w>h
noremap <A-j> <c-w>j
noremap <A-k> <c-w>k

" Resize with arrows
noremap <c-Up> :resize -2<cr>
noremap <c-Down> :resize +2<cr>
noremap <c-Left> :vertical resize -2<cr>
noremap <c-Right> :vertical resize +2<cr>
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
nmap <leader>p :Telescope find_files<CR>
" nmap <leader>p :Files!<CR>

" Bind "<leader>b" to show buffers with contents
nmap <leader>b :Buffers!<CR>

" Bind "<leader>bb" to show buffers without contents
nmap <leader>bb :call fzf#vim#buffers()<CR>

" Bind "cc" to a fzf-powered command search
nmap cc :Commands!<CR>

" Shows Git history for the current buffer
command! FileHistory execute ":BCommits"

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
let g:NERDTreeMinimalMenu=1

""""""""""""""""""""""""""""""""""""""""""""""""""""""
" textobj between
""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:textobj_between_no_default_key_mappings=1

omap id <Plug>(textobj-between-i)
omap ad <Plug>(textobj-between-a)


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

lua << EOF
local on_attach, lsp_flags = require('mylsp_settings')

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('lspconfig')['pyright'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities
}
local pid = vim.fn.getpid()
local omnisharp_bin = "/home/edvard/.cache/omnisharp-vim/omnisharp-roslyn/run"
-- local omnisharp_bin = "/mnt/c/Users/edeng655/AppData/Local/omnisharp-vim/omnisharp-rosly/OmniSharp.exe"
require('lspconfig')['omnisharp'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) }
}
require('mycmp_settings')
EOF

""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Telescope
""""""""""""""""""""""""""""""""""""""""""""""""""""""

" nnoremap <leader>fs <cmd>Telescope grep_string<cr>
nnoremap <leader>ff <cmd>Telescope git_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fd <cmd>Telescope diagnostics<cr>
nnoremap <leader>fs :Telescope grep_string search=
nnoremap <leader>fl <cmd>Telescope lsp_document_symbols<cr>
nnoremap <leader>fr <cmd>Telescope file_browser<cr>
nnoremap <leader>fc <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <leader>yk <cmd>Telescope keymaps<cr>
nnoremap <leader>yr <cmd>Telescope registers<cr>
nnoremap <leader>yc <cmd>Telescope command_history<cr>
nnoremap <leader>yh <cmd>Telescope help_tags<cr>

lua << EOF
-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
require('telescope').setup {
  defaults = {
      mappings = {
          i = {
---              ["<C-n>"] = actions.move_selection_next,
---              ["<C-p>"] = actions.move_selection_previous,
          }
      }
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')
require("telescope").load_extension "file_browser"
EOF
""""""""""""""""""""""""""""""""""""""""""""""""""""""


