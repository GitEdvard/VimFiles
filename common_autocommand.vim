"---------------------------------------------------
" Autocommand autocmd
"---------------------------------------------------
augroup indent2_augroup
    autocmd!
    autocmd FileType json,typescript,text,css,lua,html,xml,jsp setlocal shiftwidth=2 tabstop=2
augroup END

augroup csharp_augroup
    autocmd!
    autocmd FileType cs lua require('csharp.mycsharp_settings')
augroup END

augroup java_augroup
    autocmd!
    autocmd FileType java lua require('java.myjava_settings')
augroup END

augroup illuminate_augroup
    autocmd!
    autocmd VimEnter * hi link illuminatedWord CursorLine
augroup END

augroup ansible_augroup
    autocmd!
    autocmd FileType yaml setlocal autoindent expandtab tabstop=2 shiftwidth=2 cursorcolumn
augroup END

lua require('gitblame.keymaps')

" Workaround some broken plugins which set guicursor indiscriminately.
autocmd OptionSet guicursor noautocmd set guicursor=


