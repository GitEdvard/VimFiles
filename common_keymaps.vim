"---------------------------------------------------
" Keymaps
"---------------------------------------------------
" Remove "create" in auto generated veriables
" nnoremap <leader>d "_d
" set switchbuf+=usetab,newtab " open quickfix links in new tabs
nnoremap <c-Space> <c-f>
cnoremap <c-Space> <c-f>
nnoremap <leader>ku :u1<bar>u<cr>
nnoremap <leader>rx :Git blame<cr>
nmap <leader>kt 0s{ysi}<c-j><leader>=i}
nnoremap <leader>kq :Reload<cr>
nnoremap <leader>kw :PlugClean<cr>
nnoremap <leader>ke :Git fetch origin<cr>
nnoremap <leader>km <c-w><bar><c-w>_
" nnoremap <leader>kr <c-w>v:Gedit rc/dev-master:%<cr>
nnoremap <leader>kka :lua print(vim.api.nvim_eval_statusline(vim.o.statusline, {}).str)<cr>
nnoremap <leader>x "_x
nnoremap <leader>kc ebd/\u<cr>gul:noh<cr>
nnoremap <leader>kd <c-w>h:diffthis<cr><c-w>l:diffthis<cr>
nnoremap <leader>kg :tabe <cr>:Gclog<cr>
nnoremap <leader>kl <c-^>
nnoremap f i<space><esc>l
nnoremap <c-o> <c-o>zz
nnoremap <c-t> <c-t>zz
nnoremap <c-i> <c-i>zz
nnoremap dd A<bs><esc>
nnoremap <c-g><c-f> <C-w>v<C-w>Tgf
nnoremap gf <C-w>v<C-w>T:e <cfile><CR>
nnoremap <leader>o :Git add .<cr>
" nnoremap <leader>ut :retab<cr>
nnoremap <leader>J J

" Reload current file
nnoremap <leader>e :e!<CR>
nnoremap <leader>Q :bufdo bdelete<cr>

" easy insertion of ; or , in insert mode
imap ;; <esc>A;<esc>
imap ,, <esc>A,<esc>
inoremap {{ <esc>A {<c-m>}<esc>
inoremap j; <esc>la
" inoremap j; ();<esc>
inoremap j, (),
inoremap j. ().
inoremap <c-d> <esc>lxi

" Open current file in a new tab
nnoremap <leader>tr <C-w>v<C-w>T
" substitute
nnoremap <leader>v s
" Capitalize word to the left
inoremap jC <esc>bgUllgueeA
inoremap jc <esc>bgulleA

" Automatic indentation
nnoremap <leader>= =

" open file with default program
" nnoremap <leader>x :!xdg-open %<cr>

nnoremap <c-d> <c-d>zz
nnoremap <c-u> <c-u>zz

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
" noremap ; :
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

" nnoremap s f

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
nnoremap <leader>kf :lua require'common'.copy_current_file_path_to_clipboard()<cr>
nnoremap <leader>kv :lua require'common'.paste_from_clipboard()<cr>


" Resize with arrows
noremap <c-Up> :resize -2<cr>
noremap <c-Down> :resize +2<cr>
noremap <c-Left> :vertical resize -2<cr>
noremap <c-Right> :vertical resize +2<cr>

nnoremap <silent> <leader>g :tabe <bar> G<CR> <c-w>o
nnoremap <silent> <leader>G :tabe <bar> Merginal<CR> <c-w>o

noremap <C-h> :tabp<CR>
noremap - :tabm -1<CR>
noremap <C-l> :tabn<CR>
noremap = :tabm +1<CR>
noremap <C-j> :tabc<CR> :tabp<CR>
noremap <C-k> :tabe<CR>
nnoremap <buffer><silent> <leader>iv <cmd>call Black()<cr>

nnoremap <leader>q :copen<cr> <c-w>L

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
command! ShowAscii execute ":set statusline=%<%f%h%m%r%=%b\ 0x%B\ \ %l,%c%V\ %P"
lua require('git_keybindings')
