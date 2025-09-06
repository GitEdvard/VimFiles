Plug 'nvim-lualine/lualine.nvim'

lua vim.opt.termguicolors = true

augroup lualine-plug-event
    autocmd!
    autocmd User plug-event lua require('mylualine.init')
augroup END
