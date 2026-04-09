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

M.remap_next_change = function()
  vim.cmd.normal({ args = { "]c" }, bang = true })
  pcall(vim.keymap.del,'n', ",")
  pcall(vim.keymap.del,'n', ";")
  pcall(vim.keymap.set,'n', ",", "]c")
  pcall(vim.keymap.set,'n', ";", "[c")
end

M.remap_previous_change = function()
  vim.cmd.normal({ args = { "[c" }, bang = true })
  pcall(vim.keymap.del,'n', ",")
  pcall(vim.keymap.del,'n', ";")
  pcall(vim.keymap.set,'n', ",", "[c")
  pcall(vim.keymap.set,'n', ";", "]c")
end

M.remap_next_quickfixitem = function()
  vim.cmd.cnext()
  pcall(vim.keymap.del,'n', ",")
  pcall(vim.keymap.del,'n', ";")
  pcall(vim.keymap.set,'n', ",", vim.cmd.cnext)
  pcall(vim.keymap.set,'n', ";", vim.cmd.cprevious)
  -- pcall(vim.keymap.set,'n', ",", "]q")
  -- pcall(vim.keymap.set,'n', ";", "[q")
end

M.remap_previous_quickfixitem = function()
  -- vim.cmd.normal({ args = { "[q" }, bang = false })
  vim.cmd.cprevious()
  pcall(vim.keymap.del,'n', ",")
  pcall(vim.keymap.del,'n', ";")
  pcall(vim.keymap.set,'n', ",", vim.cmd.cprevious)
  pcall(vim.keymap.set,'n', ";", vim.cmd.cnext)
  -- pcall(vim.keymap.set,'n', ",", "[q")
  -- pcall(vim.keymap.set,'n', ";", "]q")
end

M.remap_next_file = function()
  vim.cmd.normal({ args = { "]f" }, bang = true })
  pcall(vim.keymap.del,'n', ",")
  pcall(vim.keymap.del,'n', ";")
  pcall(vim.keymap.set,'n', ",", "]f")
  pcall(vim.keymap.set,'n', ";", "[f")
end

M.remap_previous_file = function()
  vim.cmd.normal({ args = { "[f" }, bang = true })
  pcall(vim.keymap.del,'n', ",")
  pcall(vim.keymap.del,'n', ";")
  pcall(vim.keymap.set,'n', ",", "[f")
  pcall(vim.keymap.set,'n', ";", "]f")
end


local goto_next_bracket = function()
  local term = vim.api.nvim_replace_termcodes("j0vib<esc>jj", true, true, true)
  vim.api.nvim_feedkeys(term , "m", false)
end

local goto_previous_bracket = function()
  local term = vim.api.nvim_replace_termcodes("kk0vibo<esc>k", true, true, true)
  vim.api.nvim_feedkeys(term , "m", false)
end

M.goto_next_bracket = function()
  goto_next_bracket()
  pcall(vim.keymap.del, "n", ",")
  pcall(vim.keymap.del, "n", ";")
  pcall(vim.keymap.set, "n", ",", goto_next_bracket)
  pcall(vim.keymap.set, "n", ";", goto_previous_bracket)
end

M.goto_previous_bracket = function()
  goto_previous_bracket()
  pcall(vim.keymap.del, "n", ",")
  pcall(vim.keymap.del, "n", ";")
  pcall(vim.keymap.set, "n", ",", goto_previous_bracket)
  pcall(vim.keymap.set, "n", ";", goto_next_bracket)
end

return M
