setlocal autoindent expandtab tabstop=4 shiftwidth=4 cursorcolumn
nnoremap <leader>j J
nmap J ]pf
nmap K [pf
nmap <M-i> <plug>ApyroriInsert
imap :: <esc>A:<esc>
nnoremap <leader>ig :!darker -l 120 .<cr>
nnoremap <leader>iG :!darker -i -l 120 .<cr>

:set errorformat=%f:%l:\ %m
:set errorformat+=%f:%l:\ 
:set errorformat+=%.%#File\ \"%f\"\\,\ line\ %l\\,\ in\ %m
:set errorformat+=%f:%l:%c:%m
:set makeprg=pytest

let g:jedi#goto_command = ""
let g:jedi#goto_assignments_command = ""
let g:jedi#goto_stubs_command = ""
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = ""
let g:jedi#usages_command = ""
let g:jedi#completions_command = ""
let g:jedi#rename_command = ""
let g:jedi#rename_command_keep_name = ""

" Defined here in order to take precedence over vim-table-mode
nnoremap <leader>tt mT :e!<cr> :AttachTestMethod<cr> :echom "Bookmark is set to T"<cr>
nnoremap <leader>tu mT :e!<cr> :AttachTestMethodUnique<cr> :echom "Bookmark is set to T"<cr>
nnoremap <leader>ti mT :e!<cr> :AttachParametrized<cr> :echom "Bookmark is set to T"<cr>
nnoremap <leader>tc :e!<cr> :AttachTestClass<cr>
nnoremap <leader>tm :e!<cr> :RunTestMethod<cr>
nnoremap <leader>tf :e!<cr> :RunTestClass<cr>
nnoremap <leader>tq :DetachTestRange<cr>

" tmp?
nnoremap <leader>td :!rm -rf /home/edvard/sources/astrego/captiver/.documentation/ifu_screenshots/EU/en/*<cr>
