local Job = require("plenary.job")
local M = {}

M.copy_current_file_path_to_clipboard = function()
  local current_path = vim.fn.resolve(vim.fn.expand('%'))
  vim.cmd('!echo -n "' .. current_path .. '" | xsel -i -b')
end

M.paste_from_clipboard = function()
  local clipvalue = vim.fn.getreg('+')
  local purged_clipvalue = clipvalue:gsub("\r", "")
  vim.cmd("redir @0")
  print(purged_clipvalue)
  vim.cmd("redir END")
  vim.cmd.normal('"0P')
end

return M

