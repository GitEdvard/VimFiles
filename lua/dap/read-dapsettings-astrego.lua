local conf_mapping = {
    ['java'] = 'java',
    ['coreclr'] = 'cs',
    ['python'] = 'python'
}

for file in io.popen([[ls ".run-config"]]):lines() do 
  local single_path = ".run-config/" .. file
  local single_run_config = require'read-settings'.read_json(".run-config/" .. file)
  local cmd = single_run_config.cmd
  local cmd_split = mysplit(cmd, " ")
  local run_path = cmd_split[2]
  local args = myslice_to_end(cmd_split, 3)
  local single_config = {
    type = "python",
    request = "launch",
    name = file,
    program = "${workspaceFolder}/" .. run_path,
    args = args
  }
  table.insert(require'dap'.configurations["python"], single_config)
end

