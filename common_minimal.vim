execute pathogen#infect()

set nocompatible

let mapleader = "\<Space>"

call plug#begin('~/.vim/plugged')
Plug 'neovim/nvim-lspconfig'
Plug 'OmniSharp/omnisharp-vim'
let g:OmniSharp_loglevel = "debug"
call plug#end()

lua require('mylsp_settings2')
