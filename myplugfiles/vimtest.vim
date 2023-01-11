Plug 'vim-test/vim-test'

let test#python#runner = 'pytest'
let test#csharp#runner = 'dotnettest'
let test#strategy = "make"

augroup vimtest-plug-event
    autocmd!
    autocmd User plug-event nmap <silent> <leader>tn :TestNearest<CR>
    autocmd User plug-event nmap <silent> <leader>tf :TestFile<CR>
    autocmd User plug-event nmap <silent> <leader>ta :TestSuite<CR>
    autocmd User plug-event nmap <silent> <leader>tl :TestLast<CR>
    autocmd User plug-event nmap <silent> <leader>tv :TestVisit<CR>
augroup END
