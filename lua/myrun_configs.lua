local M = {}
require("telescope").load_extension("simple_picker")
local L = require'java.launcher'
local yapp_paths = require("java.yapp_paths")

local simple_picker = require("simple-picker")

local hello = function(prompt_bufnr)
  print("Hello")
end

local open_indata = function(selection)
  local file_path = 'run-configs/' .. selection
  L.open_indata(file_path)
end

M.list_configs = function()
  local opts = { entries = {} }
  for file in io.popen([[dir "run-configs" /b]]):lines() do 
    table.insert(opts.entries, file) 
  end
  opts.title = "Run configurations"
  opts.mappings = {
    i = {
      ['<c-i>'] = open_indata
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
  local file_path = 'run-configs/' .. metadata.text
  save_run_config(file_path)
  L.launch(file_path)
end)

return M
