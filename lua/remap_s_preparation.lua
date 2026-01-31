local M = {}

M.remap_s = function()
  local ch = vim.fn.getcharstr()
  if ch == '' then return end  -- user canceled
  -- 2) respect counts like `3sX` → `3fX`
  local count = vim.v.count1
  vim.cmd.normal({ args = { tostring(count) .. 'f' .. ch }, bang = true })  -- :normal! f{ch}

  pcall(vim.keymap.del,'n', ",")
  pcall(vim.keymap.del,'n', ";")
  pcall(vim.keymap.set,'n', ",", ";")
  pcall(vim.keymap.set,'n', ";", ",")

end

return M
