require("telescope").load_extension("run_configs")

local run_configs = require("run-configs")

run_configs.on_config_selected(function(metadata)
  print("Selected run-config: " .. metadata.text)
end)

vim.keymap.set('n', '<leader>ut', "<cmd>lua require('telescope').extensions.run_configs.run_configs()<cr>", bufopts)

