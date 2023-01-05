-- :lua package.loaded["trigger-commands"] = nil
local run_settings = require'read-settings'.read_json('.dapsettings.json')
local trigger_command = function()
    vim.cmd("let $CURRENT_PY_PATH = substitute(expand('%:r'), '/', '.', 'g')")
    require'trigger-commands'.run_single(run_settings)
end
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>u', trigger_command, opts)
