Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Let The :Files command show all files in the repo (including dotfiles)
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --glob "!.git/*"'

" fzf mappings
nmap // :BLines!<CR>

nmap ?? :Rg!<CR>

nmap <leader>p :Telescope find_files<CR>
" nmap <leader>p :Files!<CR>

" Bind "<leader>b" to show buffers with contents
nmap <leader>b :Buffers!<CR>

" Bind "<leader>bb" to show buffers without contents
nmap <leader>bb :call fzf#vim#buffers()<CR>

" Bind "cc" to a fzf-powered command search
nmap cc :Commands!<CR>

