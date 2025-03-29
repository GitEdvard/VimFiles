" https://github.com/tpope/vim-pathogen
execute pathogen#infect()

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

let mapleader = "f"

lua require('globals')
" https://github.com/junegunn/vim-plug

runtime ./common_plugs.vim
runtime ./common_basic_config.vim
runtime ./common_keymaps.vim
runtime ./common_autocommand.vim

let g:jedi#goto_command = ""
let g:jedi#goto_assignments_command = ""
let g:jedi#goto_stubs_command = ""
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = ""
let g:jedi#usages_command = ""
let g:jedi#completions_command = ""
let g:jedi#rename_command = ""
let g:jedi#rename_command_keep_name = ""

function! Tig()
  !tig status
  redraw!
endfunction
