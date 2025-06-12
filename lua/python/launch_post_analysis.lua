local M = {}

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

M.launch_latest = function()
  fetch_latest_run_setting()
  M.launch2(latest_run_setting)
end

M.launch2 = function(run_config_file)
  local run_config = require'read-settings'.read_json(run_config_file)
  cmd = run_config["cmd"]
  local launch_text = "post analysis"
  local instruction = { "hidden-scratch", cmd, { "RuntimeError" }, launch_text, "." }
  local instructions = {instruction}
  require'trigger-commands'.run_poly( instructions )
end

return M
