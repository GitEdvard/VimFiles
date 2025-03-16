-- local R = require'myrun_configs'
local U = require'java.unittestlauncher'
local G = require'git.git_commands'

local update_branch = function()
  vim.cmd("let g:fugitive_response = FugitiveHead()")
  M.update_branch(vim.g.fugitive_response)
end

local test_save = function()
  R.save_run_config("config-path")
end

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>uz', update_branch, opts)
vim.keymap.set('n', '<leader>rw', G.push_wt, bufopts)
vim.keymap.set('n', '<leader>ro', G.push_origin, bufopts)
vim.keymap.set('n', '<leader>rl', G.lg1, bufopts)
vim.keymap.set('n', '<leader>rs', G.switch_recent, bufopts)
vim.keymap.set('n', '<leader>rd', G.switch_rc_dev_master, bufopts)
vim.keymap.set('n', '<leader>rmm', G.rebase_rc_dev, bufopts)
vim.keymap.set('n', '<leader>rb', G.create_backup, bufopts)
vim.keymap.set('n', '<leader>rhh', G.reset_hard, bufopts)
vim.keymap.set('n', '<leader>rp', G.create_merge_master, bufopts)
