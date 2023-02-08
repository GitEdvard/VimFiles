local build = function()
  require'build'.build("mvn compile")
end

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>ub', build, opts)

