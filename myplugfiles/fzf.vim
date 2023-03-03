Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Let The :Files command show all files in the repo (including dotfiles)
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --glob "!.git/*"'

nmap // :BLines!<CR>
nmap ?? :Rg!<CR>
nmap <leader>p :Telescope find_files<CR>
nmap <leader>b :call fzf#vim#buffers()<CR>
" nmap cc :Commands!<CR>

" Customize the Files command to use rg which respects .gitignore files 
command! -bang -nargs=? -complete=dir Files
    \ call fzf#run(fzf#wrap('allfiles', fzf#vim#with_preview({'dir': <q-args>, 'sink': 'e', 'source': 'rg --files --hidden' }), <bang>0))

" Ignores .gitignore files
command! -bang -nargs=? -complete=dir AllFiles
    \ call fzf#run(fzf#wrap('allfiles', fzf#vim#with_preview({'dir': <q-args>, 'sink': 'e', 'source': 'rg --files --hidden --no-ignore' }), <bang>0))
nmap <leader>P :AllFiles<cr>
