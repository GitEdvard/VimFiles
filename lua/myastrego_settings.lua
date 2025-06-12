local L = require'python.launch_post_analysis'
local R = require'myrun_configs_astrego'

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>uk', L.launch, opts)
vim.keymap.set('n', '<leader>ul', L.launch_latest, opts)
vim.keymap.set('n', '<leader>ur', R.list_configs, bufopts)
