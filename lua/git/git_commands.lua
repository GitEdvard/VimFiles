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

M.push_origin_hard = function()
  vim.cmd("let g:fugitive_response = FugitiveHead()")
  local cmd = "Git push origin " .. vim.g.fugitive_response .. " -f"
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

M.reset_previous = function()
  vim.cmd("Git reset @~1")
end

M.commit_reuse_message = function()
  vim.cmd("Git commit --reuse-message=HEAD@{1}")
end

M.create_backup = function()
  vim.cmd("Git br -D backup || Git co -b backup")
end

M.rebase_rc_dev = function()
  vim.cmd("Git rebase rc/dev-master")
  print("Current branch rebased upon rc/dev-master")
end

M.create_merge_master = function()
  vim.cmd("Git br -D merge-master")
  vim.cmd("Git co -b merge-master")
  print("Deleted and created a new merge-master from current branch")
end

return M
