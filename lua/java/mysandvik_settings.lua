local M = require'java.prepare_jdtls'
local L = require'java.launcher'
local T = require'java.test'

local update_branch = function()
  vim.cmd("let g:fugitive_response = FugitiveHead()")
  M.update_branch(vim.g.fugitive_response)
end

local launch = function()
  L.launch("run-configs/gge-mea.json")
end

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>ul', launch, opts)
vim.keymap.set('n', '<leader>ub', L.build, opts)
vim.keymap.set('n', '<leader>uo', M.hide_jdtls_files, opts)
vim.keymap.set('n', '<leader>up', M.unhide_jdtls_files, opts)
-- vim.keymap.set('n', '<leader>ut', T.test, opts)
vim.keymap.set('n', '<leader>uc', L.clean, opts)
vim.keymap.set('n', '<leader>ud', M.delete_java_files, opts)
vim.keymap.set('n', '<leader>un', M.no_assume_unchanged, opts)
vim.keymap.set('n', '<leader>ua', M.assume_unchanged, opts)
vim.keymap.set('n', '<leader>ux', M.reset, opts)
vim.keymap.set('n', '<leader>uq', L.clean_all, opts)
vim.keymap.set('n', '<leader>uw', L.build_all, opts)
vim.keymap.set('n', '<leader>uh', M.hide_jdtls_files_new, opts)
vim.keymap.set('n', '<leader>uu', M.unhide_jdtls_files_new, opts)
vim.keymap.set('n', '<leader>uz', update_branch, opts)
vim.keymap.set('n', '<leader>uy', L.create_new_run_dir, opts)
-- vim.keymap.set('n', '<leader>ut', "<cmd>lua require('telescope').extensions.hello_telescope.hello_telescope()<cr>", bufopts)
