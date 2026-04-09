Plug 'NLKNguyen/papercolor-theme'

function! PaperColorSettings()
  call color_settings#CommonColorSettings()
  lua vim.opt.background="light"
  colorscheme PaperColor
endfunction

augroup papercolor-plug-event
    autocmd!
    autocmd User plug-event call PaperColorSettings()
augroup END
