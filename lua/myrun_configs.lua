require("telescope").load_extension("run_configs")
local L = require'java.launcher'

local run_configs = require("run-configs")

local list_configs = function()
  local opts = { entries = {} }
  for file in io.popen([[dir "run-configs" /b]]):lines() do 
    table.insert(opts.entries, file) 
  end
  require('telescope').extensions.run_configs.run_configs(opts)
end

run_configs.on_config_selected(function(metadata)
  local file_path = 'run-configs/' .. metadata.text
  L.launch(file_path)
end)

vim.keymap.set('n', '<leader>ut', list_configs, bufopts)
