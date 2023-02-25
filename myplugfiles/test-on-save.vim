" Plug '/home/edvard/sources/admin/VimPlugins/test-on-save.nvim'
Plug 'GitEdvard/test-on-save.nvim'

nnoremap <leader>tt :AttachTestMethod<cr>
nnoremap <leader>tc :AttachTestClass<cr>
nnoremap <leader>tm :RunTestMethod<cr>
nnoremap <leader>tf :RunTestClass<cr>
lua vim.keymap.set('n', '<leader>tr', function() vim.api.nvim_clear_autocmds({ group = "edvard-automagic" }) end, {noremap = true, silent = true})
