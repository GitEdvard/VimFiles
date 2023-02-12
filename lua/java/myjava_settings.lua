local build = function()
  require'build'.build{ "mvn compile" }
end

local package = function()
  require'build'.build{ "mvn clean package" }
end

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>ub', build, opts)
vim.keymap.set('n', '<leader>ud', package, opts)
vim.keymap.set('n', '<leader>um', '<cmd>lua require(\'jdtls.dap\').setup_dap_main_class_configs()<cr>', opts)
