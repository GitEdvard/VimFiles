local M = require'java.prepare_jdtls'
local L = require'java.launcher'
local T = require'java.test'
local R = require'myrun_configs'
local V = require'java.update_version'
local U = require'java.unittestlauncher'
local G = require'git.git_commands'

local update_branch = function()
  vim.cmd("let g:fugitive_response = FugitiveHead()")
  M.update_branch(vim.g.fugitive_response)
end

local launch = function()
  L.launch("run-configs/gge-mea-atlas.json")
end

local delete_java_files = function()
  vim.cmd("let g:fugitive_response = FugitiveHead()")
  M.delete_java_files(vim.g.fugitive_response)
end

local test_copy = function()
  L.test_copy("run-configs/marking.json")
end

local test_save = function()
  R.save_run_config("config-path")
end

local opts = { noremap = true, silent = true }
-- vim.keymap.set('n', '<leader>ul', launch, opts)
vim.keymap.set('n', '<leader>ul', L.launch_latest, opts)
vim.keymap.set('n', '<leader>ut', test_save, opts)
vim.keymap.set('n', '<leader>ub', L.build, opts)
-- vim.keymap.set('n', '<leader>ut', test_copy, opts)
vim.keymap.set('n', '<leader>uo', L.open_prt, opts)
vim.keymap.set('n', '<leader>u[', L.open_job, opts)
vim.keymap.set('n', '<leader>up', L.open_json, opts)
vim.keymap.set('n', '<leader>ud', delete_java_files, opts)
vim.keymap.set('n', '<leader>ux', M.reset, opts)
vim.keymap.set('n', '<leader>uq', L.build_all, opts)
vim.keymap.set('n', '<leader>uw', L.clean_and_build_all, opts)
vim.keymap.set('n', '<leader>uh', M.hide_jdtls_files_new, opts)
vim.keymap.set('n', '<leader>uu', M.unhide_jdtls_files_new, opts)
vim.keymap.set('n', '<leader>uz', update_branch, opts)
vim.keymap.set('n', '<leader>ur', R.list_configs, bufopts)
vim.keymap.set('n', '<leader>uv', V.update_version, bufopts)
vim.keymap.set('n', '<leader>ue', M.copy_reference_files, bufopts)
vim.keymap.set('n', '<leader>rw', G.push_wt, bufopts)
vim.keymap.set('n', '<leader>ro', G.push_origin, bufopts)
vim.keymap.set('n', '<leader>rl', G.lg1, bufopts)
vim.keymap.set('n', '<leader>rs', G.switch_recent, bufopts)
-- vim.keymap.set('n', '<leader>ut', "<cmd>lua require('telescope').extensions.hello_telescope.hello_telescope()<cr>", bufopts)
