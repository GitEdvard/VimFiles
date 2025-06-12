require("telescope").load_extension("simple_picker")
local M = {}
local L = require'python.launch_post_analysis'

local simple_picker = require("simple-picker")

local open_config_file = function(selection)
  local config_file_path = '.run-config/' .. selection
  vim.cmd('tabe ' .. config_file_path)
end

local copy_path_clipboard = function(selection)
  local config_file_path = '.run-config/' .. selection
  local run_config = require'read-settings'.read_json(config_file_path) or {}
  local winpath = run_config["winpath"]
  vim.cmd('!echo "' .. winpath .. '" | xsel -b')
end


M.list_configs = function()
  local opts = { entries = {} }
  for file in io.popen([[ls ".run-config"]]):lines() do 
    table.insert(opts.entries, file) 
  end
  opts.title = "Run configurations"
  opts.mappings = {
    i = {
      ['<c-i>'] = copy_path_clipboard,
      ['<c-o>'] = open_config_file
    }
  }
  require('telescope').extensions.simple_picker.simple_picker(opts)
end

simple_picker.on_config_selected(function(metadata)
  local save_run_config = function(config_file)
    local settings_table = require'read-settings'.read_json(vim.g.vim_settings_file) or {}
    file = io.open(vim.g.vim_settings_file, "w")
    runconfig_setting = {[vim.g.vim_settings_config_entry]=config_file}
    for k, v in pairs(runconfig_setting) do settings_table[k] = v end
    json_content = vim.json.encode(settings_table)
    file:write(json_content)
    file:close()
  end
  local file_path = '.run-config/' .. metadata.text
  save_run_config(file_path)
  L.launch2(file_path)
  print(metadata.text)
end)

return M
