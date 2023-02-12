local build = function()
  require'build'.build{ "mvn compile" }
end

local package = function()
  require'build'.build{ "mvn clean package; shutdown.sh; startup.sh" }
end

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>ub', build, opts)
vim.keymap.set('n', '<leader>ud', package, opts)
