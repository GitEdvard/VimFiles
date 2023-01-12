Plug 'neovim/nvim-lspconfig'
Plug 'mfussenegger/nvim-lint'
" Autocompletion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer', {'do': 'make'}
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'onsails/lspkind.nvim'


set completeopt=menu,menuone,noselect

augroup lsp-plug-event
    autocmd!
    autocmd User plug-event lua require('mylsp_settings')
augroup END
