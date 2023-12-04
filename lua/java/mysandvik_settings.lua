local M = require'java.prepare_jdtls'
local L = require'java.launcher'
local T = require'java.test'
local R = require'myrun_configs'

local update_branch = function()
  vim.cmd("let g:fugitive_response = FugitiveHead()")
  M.update_branch(vim.g.fugitive_response)
end

local launch = function()
  L.launch("run-configs/gif-mea.json")
end

local delete_java_files = function()
  vim.cmd("let g:fugitive_response = FugitiveHead()")
  M.delete_java_files(vim.g.fugitive_response)
end

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>ul', launch, opts)
vim.keymap.set('n', '<leader>ut', T.test, opts)
vim.keymap.set('n', '<leader>ub', L.build, opts)
-- vim.keymap.set('n', '<leader>ut', L.open_prt, opts)
vim.keymap.set('n', '<leader>uo', L.open_prt, opts)
vim.keymap.set('n', '<leader>ud', delete_java_files, opts)
vim.keymap.set('n', '<leader>ux', M.reset, opts)
vim.keymap.set('n', '<leader>uq', L.build_all, opts)
vim.keymap.set('n', '<leader>uw', L.clean_and_build_all, opts)
vim.keymap.set('n', '<leader>uh', M.hide_jdtls_files_new, opts)
vim.keymap.set('n', '<leader>uu', M.unhide_jdtls_files_new, opts)
vim.keymap.set('n', '<leader>uz', update_branch, opts)
vim.keymap.set('n', '<leader>ur', R.list_configs, bufopts)
-- vim.keymap.set('n', '<leader>ut', "<cmd>lua require('telescope').extensions.hello_telescope.hello_telescope()<cr>", bufopts)
