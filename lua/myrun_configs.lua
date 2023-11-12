local M = {}
require("telescope").load_extension("simple_picker")
local L = require'java.launcher'

local simple_picker = require("simple-picker")

M.list_configs = function()
  local opts = { entries = {} }
  for file in io.popen([[dir "run-configs" /b]]):lines() do 
    table.insert(opts.entries, file) 
  end
  opts.title = "Run configurations"
  require('telescope').extensions.simple_picker.simple_picker(opts)
end

simple_picker.on_config_selected(function(metadata)
  local file_path = 'run-configs/' .. metadata.text
  L.launch(file_path)
end)

return M
