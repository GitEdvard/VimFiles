local M = {}

M.copy_current_file_path_to_clipboard = function()
  local current_path = vim.fn.resolve(vim.fn.expand('%'))
  vim.cmd('!echo -n "' .. current_path .. '" | xsel -i -b')
end

return M
