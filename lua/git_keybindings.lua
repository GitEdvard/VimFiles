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

local fetch_origin = function()
  vim.cmd("Git fetch origin")
end

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>ro', G.push_origin, bufopts)
vim.keymap.set('n', '<leader>rO', G.push_origin_hard, bufopts)
vim.keymap.set('n', '<leader>rl', G.lg1, bufopts)
vim.keymap.set('n', '<leader>rs', G.switch_recent, bufopts)
vim.keymap.set('n', '<leader>rb', G.create_backup, bufopts)
vim.keymap.set('n', '<leader>rhh', G.reset_hard, bufopts)

vim.keymap.set('n', '<leader>rp', G.reset_previous, bufopts)
vim.keymap.set('n', '<leader>rr', G.commit_reuse_message, bufopts)
vim.keymap.set('n', '<leader>rk', fetch_origin, bufopts)
