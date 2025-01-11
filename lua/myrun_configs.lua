local M = {}
require("telescope").load_extension("config_picker")
local L = require'java.launcher'
local yapp_paths = require("java.yapp_paths")

local config_picker = require("config-picker")

M.list_configs = function()
  local opts = { entries = {} }
  for file in io.popen([[dir "run-configs" /b]]):lines() do 
    table.insert(opts.entries, file) 
  end
  opts.title = "Run configurations"
  require('telescope').extensions.config_picker.config_picker(opts)
end

config_picker.on_config_selected(function(metadata)
  local save_run_config = function(config_file)
    local settings_table = require'read-settings'.read_json(vim.g.vim_settings_file) or {}
    file = io.open(vim.g.vim_settings_file, "w")
    runconfig_setting = {[vim.g.vim_settings_config_entry]=config_file}
    for k, v in pairs(runconfig_setting) do settings_table[k] = v end
    json_content = vim.json.encode(settings_table)
    file:write(json_content)
    file:close()
  end
  local file_path = 'run-configs/' .. metadata.text
  save_run_config(file_path)
  L.launch(file_path)
end)

config_picker.on_indata_open(function(metadata)
  local file_path = 'run-configs/' .. metadata.text
  local config_table = require'read-settings'.read_json(file_path)
  local project_name = config_table.project
  -- local parameter_files = yapp_paths.find_root_path() .. "\\" .. project_name .. "\\parameter-files\\"
  local parameter_files = vim.fn.getcwd() .. "\\" .. project_name .. "\\parameter-files\\"
  local indata_path = parameter_files .. config_table.pfile
  vim.cmd('tabe ' .. indata_path)
end)

M.open_indata = function()
  print("hej")
end

return M
