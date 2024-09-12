local M = {}

M.push_wt = function()
  vim.cmd("let g:fugitive_response = FugitiveHead()")
  local cmd = "Git push wt " .. vim.g.fugitive_response
  vim.cmd(cmd)
end

M.push_origin = function()
  vim.cmd("let g:fugitive_response = FugitiveHead()")
  local cmd = "Git push origin " .. vim.g.fugitive_response
  vim.cmd(cmd)
end

M.lg1 = function()
  vim.cmd("Git lg1")
end

M.switch_recent = function()
  vim.cmd("Git co -")
end

return M
