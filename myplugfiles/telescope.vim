Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'nvim-telescope/telescope-file-browser.nvim'
" Note!!!! Go to directory where telescope-fzf-native is installed, and run
" make clean && make
" will take care of E5108: Error executing lua  'fzf' extension doesn't exist
" or isn't installed"
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
Plug 'nvim-telescope/telescope-ui-select.nvim'

augroup telescope-plug-event
    autocmd!
    autocmd User plug-event lua require('mytelescope')
augroup END
