local conf_mapping = {
    ['java'] = 'java',
    ['coreclr'] = 'cs',
    ['python'] = 'python'
}

local dap_config = require'read-settings'.read_json(".dapsettings.json")
if dap_config ~= nil then
    local filetype = conf_mapping[dap_config['type']]
    require'dap'.configurations[filetype] = {dap_config}
end

-- example of how to trigger clarity debugger
-- vim.keymap.set("n", "<F5>", ":let $CURRENT_PY_PATH=substitute(expand('%:r'), '/', '.', 'g')<CR> :lua require'dap'.continue()<cr>", opts)

