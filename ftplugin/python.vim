setlocal autoindent expandtab tabstop=4 shiftwidth=4 cursorcolumn
nnoremap <leader>j J
nmap J ]pf
nmap K [pf
imap :: <esc>A:<esc>

:set errorformat=%f:%l:\ %m
:set errorformat+=%.%#File\ \"%f\"\\,\ line\ %l\\,\ in\ %m
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

