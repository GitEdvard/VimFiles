Plug 'neovim/nvim-lspconfig'
Plug 'mfussenegger/nvim-lint'
" Autocompletion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer', {'do': 'make'}
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'onsails/lspkind.nvim'
Plug 'williamboman/nvim-lsp-installer'

set completeopt=menu,menuone,noselect

augroup lsp-plug-event
    autocmd!
    autocmd User plug-event lua require('lsp.mylsp_settings')
augroup END
