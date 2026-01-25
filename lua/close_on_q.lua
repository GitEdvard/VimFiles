-- utils/qf_cond.lua
local M = {}

M.schedule_close_on_q_for_filetypes = function()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = {"fugitiveblame", "dap-float"},
    callback = function()
      vim.schedule(function()
        vim.keymap.set("n", "q", ":bd<cr>", {buffer = true})
      end)
    end,
  })
end

local is_ctrlfs_open = function()
  local wins = vim.api.nvim_tabpage_list_wins(0)
  for _, w in ipairs(wins) do
    local mybuf = vim.api.nvim_win_get_buf(w)
    local ft = vim.api.nvim_get_option_value("filetype", { buf = mybuf })
    if ft:find("ctrlsf") then
      return true
    end
  end
  return false
end

local let_current_q_mapping_be = function()
  local ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
  return  is_ctrlfs_open() or (ft == "qf")
end

---Return true if the current tabpage shows a split AND another window is a quickfix.
---@param include_loclist boolean|nil  -- also treat loclist as quickfix-like
local is_split_with_quickfix = function()
  local wins = vim.api.nvim_tabpage_list_wins(0)
  if #wins < 2 then
    return false
  end

  local cur = vim.api.nvim_get_current_win()

  -- You can use either win_gettype() or getwininfo(). Both are fine.
  -- win_gettype(): "quickfix" | "loclist" | "preview" | "" (normal)
  for _, w in ipairs(wins) do
    if w ~= cur then
      local typ = vim.fn.win_gettype(w)
      if typ == "quickfix" or typ == "loclist" then
        return true
      end
    end
  end

  return false
end


-- Close all quickfix windows in the current tabpage
local function close_quickfix_in_current_tab()
  pcall(vim.keymap.del,"n", "q", {buffer = 0})
  local wins = vim.api.nvim_tabpage_list_wins(0)
  for _, w in ipairs(wins) do
    local typ = vim.fn.win_gettype(w)
    if typ == "quickfix" then
      -- Force-close the window; use false instead of true if you want to block when there are unsaved changes
      pcall(vim.api.nvim_win_close, w, true)
    end
  end
end

-- Recalculate window count and detect transitions
local function close_quickfix_with_q()
  if let_current_q_mapping_be() then
    return
  end
  if is_split_with_quickfix() then
    vim.keymap.set("n", "q", close_quickfix_in_current_tab, {buffer = true})
  else
    pcall(vim.keymap.del,"n", "q", {buffer = 0})
  end
end

-- Setup autocmds
function M.close_quickfix_with_q()
  local aug = vim.api.nvim_create_augroup("SplitWatcher", { clear = true })

  vim.api.nvim_create_autocmd({ "WinEnter", "WinNew", "WinClosed" }, {
    group = aug,
    callback = close_quickfix_with_q,
  })
end

return M
