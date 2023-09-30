Plug 'C:\Users\yh6032\HOME\git_me\git-worktree.windows.nvim'
" Plug 'ThePrimeagen/git-worktree.nvim'


augroup git-worktree-plug-event
    autocmd!
    autocmd User plug-event lua require('mygit_worktree')
augroup END
