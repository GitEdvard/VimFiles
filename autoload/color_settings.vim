
function! color_settings#CommonColorSettings()
  set cursorline
  highlight CursorLine ctermbg=Yellow cterm=bold guibg=#2b2b2b
  lua vim.opt.termguicolors = true
  set t_Co=256
endfunction

