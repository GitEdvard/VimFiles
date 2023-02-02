local build = function()
  require'csharp_build'.build()
end

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>ub', build, opts)
