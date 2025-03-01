Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/playground'

augroup treesitter-plug-event
    autocmd!
    autocmd User plug-event lua require('mytreesitter')
augroup END
