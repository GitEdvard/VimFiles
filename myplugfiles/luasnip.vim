Plug 'L3MON4D3/LuaSnip'
Plug 'capaj/vscode-standardjs-snippets'
Plug 'abusaidm/html-snippets'
Plug 'johnpapa/vscode-angular-snippets'
" I copy&paste from the friendly-snippets directory to luasnippets directory
Plug 'rafamadriz/friendly-snippets'

augroup luasnip-plug-event
    autocmd!
    autocmd User plug-event lua require('luasnip.myluasnip_settings')
augroup END
