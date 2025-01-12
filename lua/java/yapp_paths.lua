local M = {}

M.find_root_path = function()
  local build_path = vim.fs.find(
  {'build.properties'}, 
  { upward = true, path = vim.fs.dirname(vim.api.nvim_buf_get_name(0)) })
  local build_path = build_path[1]
  local project_path = vim.fs.dirname(build_path)
  local root_path = vim.fs.dirname(project_path)
  return root_path
end

return M
