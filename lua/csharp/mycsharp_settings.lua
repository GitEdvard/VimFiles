local build = function()
  require'trigger-commands'.run_silent{ "dotnet build" }
end

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>ub', build, opts)
