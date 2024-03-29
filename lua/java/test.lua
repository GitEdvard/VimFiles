local M = {}

M.test = function()
  local timestamp = os.time()
  local numberdays = 3
  local seconds_per_day = 60 * 60 * 24
  local timediff = numberdays * seconds_per_day
  local treashold_time = timestamp - timediff
  print(os.date("date: %m/%d/%Y %I:%M %p", treashold_time))
end

M.test_simple = function()
  -- local cmd = "java -jar " .. vim.g.java_files_base .. "/launcher_dir/formatting/org.eclipse.osgi_3.12.100.v20180210-1608.jar -config " .. vim.g.nvim_adapt_root .. "/yapp_format.ini " .. vim.api.nvim_buf_get_name(0)
  local cmd = "java -jar C:/Users/yh6032/HOME/java_files/launcher-dir/formatting/org.eclipse.osgi_3.12.100.v20180210-1608.jar -config " .. vim.g.nvim_adapt_root .. "/yapp_format.ini " .. vim.api.nvim_buf_get_name(0)
  P(cmd)
  require'trigger-commands'.run_single(cmd)
end

local print_dir_contents = function()
  for dir in io.popen([[dir "run-configs" /b]]):lines() do print(dir) end
end

M.test_multi_line = function()
  local cmd = [[echo "hello1"
  echo "hello2"]]
  require'trigger-commands'.run_single( cmd )
end

return M
