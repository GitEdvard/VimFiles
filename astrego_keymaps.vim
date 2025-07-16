nnoremap <leader>kp viW:s/\\/\//g<cr> \| viW:s/\s*\zs\(.\{-}\):\ze/\/mnt\/\L\1/<cr>
nnoremap <leader>kP viW:s/\//\\/g<cr> \| viW:s/\s*\zs\\mnt\\\(.\{-}\)\\\ze/\U\1:\\<cr>
nnoremap <leader>ks viW:s/\\/\\\\/g<cr> \| :noh<cr>
nnoremap <leader>kS viW:s/\\\\/\\/g<cr> \| :noh<cr>
nmap <leader>kn vib<esc>j
nmap <leader>kN vibo<esc>k
nnoremap <leader>ru :Git submodule update<cr>

