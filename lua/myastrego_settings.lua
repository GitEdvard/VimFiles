local L = require'python.launch_post_analysis'
local R = require'myrun_configs_astrego'
local S = require'python.mypythonlsp'
local Q = require'mylualine.mystatusline'

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>uk', L.launch, opts)
vim.keymap.set('n', '<leader>ul', L.launch_latest, opts)
vim.keymap.set('n', '<leader>ur', R.list_configs, bufopts)
vim.keymap.set('n', '<leader>uo', L.open_latest, bufopts)
vim.keymap.set('n', '<leader>up', L.open_latest_in_nvim, bufopts)
vim.keymap.set('n', '<leader>iu', S.goto_superclass, bufopts)
vim.keymap.set('n', '<leader>iU', S.show_class_family, bufopts)
vim.keymap.set('n', '<leader>im', S.show_method_definitions, bufopts)
vim.keymap.set('n', '<leader>iM', S.show_method_usages, bufopts)
vim.keymap.set('n', '<leader>uc', R.create_config, bufopts)
vim.keymap.set('n', '<leader>ik', S.show_method_definitions_caret, bufopts)
vim.keymap.set('n', '<leader>iK', S.show_method_usages_caret, bufopts)
vim.keymap.set('n', '<leader>il', S.show_latest_method_search, bufopts)
vim.keymap.set('n', '<leader>kK', Q.evaluate_statusline, bufopts)
vim.keymap.set('n', '<leader>kkb', Q.statusline_len, bufopts)
vim.keymap.set('n', '<leader>kkc', Q.internal_statusline, bufopts)
vim.keymap.set('n', '<leader>kkd', Q.print_components, bufopts)
