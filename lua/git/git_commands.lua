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

M.switch_rc_dev_master = function()
  vim.cmd("Git co rc/dev-master")
end

M.reset_hard = function()
  vim.cmd("Git reset --hard")
end

M.create_backup = function()
  vim.cmd("Git br -D backup || Git co -b backup")
end

M.rebase_rc_dev = function()
  vim.cmd("Git rebase rc/dev-master")
end

return M
