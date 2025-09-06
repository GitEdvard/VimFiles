Plug 'famiu/feline.nvim'

lua vim.opt.termguicolors = true

augroup feline-plug-event
    autocmd!
    autocmd User plug-event lua require('myfeline.init')
augroup END
