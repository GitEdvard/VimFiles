Plug 'L3MON4D3/LuaSnip'
Plug 'capaj/vscode-standardjs-snippets'
Plug 'abusaidm/html-snippets'
Plug 'johnpapa/vscode-angular-snippets'

augroup luasnip-plug-event
    autocmd!
    autocmd User plug-event lua require('luasnip.myluasnip_settings')
augroup END
