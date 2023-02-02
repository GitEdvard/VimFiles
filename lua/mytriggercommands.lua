-- :lua package.loaded["trigger-commands"] = nil
local run_settings = require'read-settings'.read_json('.runsettings.json')
local trigger_command_single = function()
    vim.cmd("let $CURRENT_PY_PATH = substitute(expand('%:r'), '/', '.', 'g')")
    require'trigger-commands'.run_single(run_settings)
end
local opts = { noremap = true, silent = true }

local run_settings = require'read-settings'.read_json('.runrestsettings.json')
local trigger_command_rest = function()
    require'trigger-commands'.run_rest_call(run_settings)
end

local reset = function()
    package.loaded['trigger-commands'] = nil
    package.loaded['mytriggercommands'] = nil
end
vim.keymap.set('n', '<leader>us', trigger_command_single, opts)
vim.keymap.set('n', '<leader>ur', trigger_command_rest, opts)
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

