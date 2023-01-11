Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Let The :Files command show all files in the repo (including dotfiles)
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --glob "!.git/*"'

nmap // :BLines!<CR>
nmap ?? :Rg!<CR>
nmap <leader>p :Telescope find_files<CR>
nmap <leader>b :Buffers!<CR>
nmap <leader>bb :call fzf#vim#buffers()<CR>
nmap cc :Commands!<CR>
