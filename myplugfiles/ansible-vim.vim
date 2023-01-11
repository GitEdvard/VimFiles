Plug 'pearofducks/ansible-vim'

source ~/.vim/myscripts/find_ansible_role.vim
let g:ansible_unindent_after_newline = 1
let g:ansible_name_highlight = 'd'
let g:ansible_extra_keywords_highlight = 1
let g:ansible_extra_keywords_highlight_group = 'Statement'
let g:ansible_normal_keywords_highlight = 'Constant'
let g:ansible_template_syntaxes = { '*.rb.j2': 'ruby' }
let g:ansible_ftdetect_filename_regex = '\v(playbook|site|main|local|requirements)\.ya?ml$'

" Open role under cursor. First open current buffer in a new tab.
" snpseq ansible stuff
au BufRead,BufNewFile */system-management/snpseq/*.yml nnoremap <leader>r <C-w>v<C-w>T:call FindAnsibleRoleUnderCursor()<CR>
au BufRead,BufNewFile */system-management/snpseq/*.yml vnoremap <leader>r <C-w>v<C-w>T:call FindAnsibleRoleUnderCursor()<CR>

au BufRead,BufNewFile */miarka-provision/*.yml nnoremap <leader>r <C-w>v<C-w>T:call FindAnsibleRoleUnderCursor()<CR>
au BufRead,BufNewFile */miarka-provision/*.yml vnoremap <leader>r <C-w>v<C-w>T:call FindAnsibleRoleUnderCursor()<CR>

au BufRead,BufNewFile */ansible/*.yml nnoremap <leader>r <C-w>v<C-w>T:call FindAnsibleRoleUnderCursor()<CR>
au BufRead,BufNewFile */ansible/*.yml vnoremap <leader>r <C-w>v<C-w>T:call FindAnsibleRoleUnderCursor()<CR>

