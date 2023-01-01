" Basically following the human mode settings, with exception leader is
" replaced with shift
nnoremap <F5> :call vimspector#Launch()<CR>
nnoremap <F17> :call vimspector#Reset()<CR> " This is <s-f5>
nmap <F10> <Plug>VimspectorStepOver
nmap <F11> <Plug>VimspectorStepInto
nmap <F23> <Plug>VimspectorStepOut " This is <s-f11>
nnoremap <F9> :call vimspector#ToggleBreakpoint()<CR>
nnoremap <F21> <Plug>VimspectorToggleConditionalBreakpoint " this is <s-f9>
nnoremap <F29> :OmniSharpDebugTest<CR> " This is <c-f5>
nmap <Leader>di <Plug>VimspectorBalloonEval
xmap <Leader>di <Plug>VimspectorBalloonEval
nnoremap <F5> :call vimspector#Continue()<CR>
nnoremap <F3> :call vimspector#Stop()<CR>
nnoremap <F4> <Plug>VimspectorRestart
nnoremap <F6> <Plug>VimspectorPause

nnoremap <F8> <Plug>VimspectorAddFunctionBreakpoint
nnoremap <F20> <Plug>VimspectorRunToCursor " this is <s-f8>
nnoremap <Leader>dT :call vimspector#ClearBreakpoints()<CR>
