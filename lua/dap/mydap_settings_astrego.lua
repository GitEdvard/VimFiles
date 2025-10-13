local repo = vim.fn.getcwd()
if repo:find("captiver") then
  require("dap.read-dapsettings-astrego")
end
