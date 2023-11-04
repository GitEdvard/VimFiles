local M = {}

M.test = function()
  local run_config = require'read-settings'.read_json('run-configs/gge-mea.json')
  P(run_config.mc)
end

M.test_simple = function()
  require'trigger-commands'.run_launcher{"echo hello " .. vim.fn.strftime("%FT%T%z"), "xxx"}
end

M.test_multi_line = function()
  local cmd = [[echo "hello1"
  echo "hello2"]]
  require'trigger-commands'.run_single( cmd )
end

return M
