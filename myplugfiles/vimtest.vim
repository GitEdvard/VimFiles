Plug 'vim-test/vim-test'

let test#python#runner = 'pytest'
let test#csharp#runner = 'dotnettest'
let test#strategy = "make"

nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ta :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tv :TestVisit<CR>
