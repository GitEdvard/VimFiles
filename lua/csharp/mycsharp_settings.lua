local build = function()
  require'build'.build{ "dotnet build" }
end

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>ub', build, opts)
