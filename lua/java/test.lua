local M = {}

M.test = function()
  local util = require'formatter.util'
  print(util.escape_path(util.get_current_buffer_file_name()))
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
