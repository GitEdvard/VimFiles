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

function! Tig()
  !tig status
  redraw!
endfunction
