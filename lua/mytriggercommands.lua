-- :lua package.loaded["trigger-commands"] = nil
local run_settings = require'read-settings'.read_json('.dapsettings.json')
local trigger_command = function()
    vim.cmd("let $CURRENT_PY_PATH = substitute(expand('%:r'), '/', '.', 'g')")
    require'trigger-commands'.run_single(run_settings)
end
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>us', trigger_command, opts)

local run_settings = require'read-settings'.read_json('.runrestsettings.json')
local trigger_command = function()
    require'trigger-commands'.run_rest_call(run_settings)
end
vim.keymap.set('n', '<leader>ur', trigger_command, opts)

local reset = function()
    package.loaded['trigger-commands'] = nil
    package.loaded['mytriggercommands'] = nil
end
vim.keymap.set('n', '<leader>uc', reset)

-- local hello = function()
--     print('hello')
-- end

-- local trigger_group = vim.api.nvim_create_augroup('my-trigger-commands', { clear = true })

-- vim.cmd("autocmd User myevent echo 'hello'")
-- vim.api.nvim_create_autocmd('User', {
--     pattern = 'myevent',
--     group = trigger_group,
--     command = 'lua hello()'
-- })

