require("telescope").load_extension("simple_picker")
local filepath_picker = require("telescope.filepath_picker")
local Job = require("plenary.job")
local M = {}
local L = require'python.launch_post_analysis'

local simple_picker = require("simple-picker")



-- Lua implementation of PHP scandir function
local scandir = function(directory)
  local i, t, popen = 0, {}, io.popen
  local inside_worktree_job = Job:new({
    'ls', directory,
    cwd = cwd,
  })
  local stdout, code = inside_worktree_job:sync()
  return stdout
end

local filter = function(a_table, pattern)
  local out = {}
  for k, v in ipairs(a_table) do
    if v ~= nil and v:find(pattern) then
      table.insert(out, v)
    end
  end
  return out
end

local find_latest_run_dir = function(dataanalyst_dir)
  local run_dirs = scandir(dataanalyst_dir)
  local date_pattern = "^%d+[-]%d+[-]%d+[_]%d+$"
  run_dirs = filter(run_dirs, date_pattern)
  table.sort(run_dirs, function(a, b) return a > b end) -- reversed sorting
  return run_dirs[1]
end

local copy_path_clipboard = function(selection)
  local config_file_path = '.run-config/' .. selection
  local run_config = require'read-settings'.read_json(config_file_path) or {}
  local winpath = run_config["winpath"]
  local dataanalyst_win = winpath .. "\\Raw\\DataAnalyst"
  local dataanalyst_linux1 = dataanalyst_win:gsub("\\", "/")
  local dataanalyst_linux2 = dataanalyst_linux1:gsub("(.):", function(x) return "/mnt/" .. x:lower() end)
  local latest_rundir = find_latest_run_dir(dataanalyst_linux2)
  vim.cmd('!echo -n "' .. winpath .. '\\Raw\\DataAnalyst\\' .. latest_rundir ..'" | xsel -b')
end

local open_config_file = function(selection)
  local config_file_path = '.run-config/' .. selection
  vim.cmd('tabe ' .. config_file_path)
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
      ['<c-t>'] = open_config_file
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
  local current_pwd = vim.fn.getcwd()
  if string.find(current_pwd, "captiver") then
    L.launch2(file_path)
  else
    L.launch_ordinary(file_path)
  end
end)

local write_to_config_file = function(file_name, selection)
    if not isdir(".run-config") then
      os.execute("mkdir .run-config")
    end
    local path_to_template = "/home/edvard/.vim/lua/run-config-template.txt"
    local contents = lines_from(path_to_template)
    vim.cmd("redir! > .run-config/"..file_name)
    for _, line in pairs(contents) do
      if not (line == "" or line == nil) then
        line = line:gsub("<placeholder>", "python "..selection)
        print(line)
      end
    end
    vim.cmd("redir END")
end

M.create_config = function()
  vim.ui.input({ prompt = 'Enter name of run-config file, without extension: ' }, function(input)
    file_name = input .. ".json"
    local on_select = function(selection)
      write_to_config_file(file_name, selection)
    end
    filepath_picker.filepath_picker(on_select)
  end)
end

return M
