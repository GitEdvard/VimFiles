local M = {}

M.evaluate_statusline = function()
  local statusline = vim.api.nvim_eval_statusline(vim.o.statusline, {})
  if string.find(statusline.str, "<") then
    print("Too long")
  else
    print("status line fits")
  end
end

M.statusline_len = function()
  local statusline = vim.api.nvim_eval_statusline(vim.o.statusline, {})
  print("Length of status line: "..string.len(statusline.str))
  local win_id = vim.api.nvim_get_current_win()
  local width = vim.api.nvim_win_get_width(win_id)
  print("Window width: "..width)
end

M.internal_statusline = function()
  local statusline = require'lualine'.statusline(true)
  print("statusline: "..statusline)
  statusline = statusline:gsub("%%#(.-)#", "")
  statusline = statusline:gsub("%%<", "")
  statusline = statusline:gsub("%%=", "")
  -- statusline = statusline:gsub("%%", "%")
  print("statusline: "..statusline)
  print("Length of statusline: "..string.len(statusline))
end

M.print_components = function()
  local show_components = require'lualine'.show_components(true)
end

return M

