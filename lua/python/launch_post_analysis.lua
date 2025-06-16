local Job = require("plenary.job")
local M = {}
local run_config_file_instance = ""

local latest_run_setting = ""

M.launch = function()
  local run_settings = require'read-settings'.read_json('.command.json')
  P(run_settings["cmd"])
  cmd = run_settings["cmd"]
  local launch_text = "post analysis"
  local instruction = { "hidden-scratch", cmd, { "RuntimeError" }, launch_text, "." }
  local instructions = {instruction}
  require'trigger-commands'.run_poly( instructions )
end

local fetch_latest_run_setting = function()
  if latest_run_setting == "" then
    local settings_table = require'read-settings'.read_json(vim.g.vim_settings_file) or {}
    latest_run_setting = settings_table[vim.g.vim_settings_config_entry] or ""
    if latest_run_setting == "" then
      print("No latest run setting available, you have to choose a single run first!")
      return
    end
  end
end

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

local copy_path_clipboard = function(run_config_file)
  local run_config = require'read-settings'.read_json(run_config_file) or {}
  local winpath = run_config["winpath"]
  local dataanalyst_win = winpath .. "\\Raw\\DataAnalyst"
  local dataanalyst_linux1 = dataanalyst_win:gsub("\\", "/")
  local dataanalyst_linux2 = dataanalyst_linux1:gsub("(.):", function(x) return "/mnt/" .. x:lower() end)
  local latest_rundir = find_latest_run_dir(dataanalyst_linux2)
  print("latest_rundir")
  P(latest_rundir)
  vim.cmd('!echo -n "' .. winpath .. '\\Raw\\DataAnalyst\\' .. latest_rundir ..'" | xsel -b')
end

M.launch_latest = function()
  fetch_latest_run_setting()
  M.launch2(latest_run_setting)
end

local copy_path_clipboard_wrapped = function()
  copy_path_clipboard(run_config_file_instance)
end

M.launch2 = function(run_config_file)
  run_config_file_instance = run_config_file
  local run_config = require'read-settings'.read_json(run_config_file)
  cmd = run_config["cmd"]
  local launch_text = "post analysis"
  local instruction1 = { "hidden-scratch", cmd, { "RuntimeError" }, launch_text, "." }
  local instruction2 = { "lua", copy_path_clipboard_wrapped, "Copy runpath" }
  local instructions = {instruction1, instruction2}
  require'trigger-commands'.run_poly( instructions )
end

return M
