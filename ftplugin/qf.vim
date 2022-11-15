" quickfix window
" vim.api.nvim_set_keymap('n', '<c-j>', 'cn<cr><c-w><c-p>', { noremap = true, silent = true, buffer = true })
" vim.api.nvim_set_keymap('n', '<c-k>', 'cp<cr><c-w><c-p>', { noremap = true, silent = true, buffer = true })
" vim.api.nvim_set_keymap('n', 'q', 'bd<cr>', { noremap = true, silent = true, buffer = true })
nnoremap <buffer> <c-j> :cn<cr><c-w><c-p>
nnoremap <buffer> <c-k> :cp<cr><c-w><c-p>
nnoremap <buffer> q :bd<cr>
