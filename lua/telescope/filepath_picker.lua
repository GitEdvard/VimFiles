
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values

local M = {}

M.filepath_picker = function(on_select)
  local selection = ""
  pickers.new({}, {
    prompt_title = "Pick a file",
    finder = finders.new_oneshot_job({ "rg", "--files", "--color", "never" }, {}),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        local full_path = selection[1]
        -- print("selected file:"..M.selection)
        if on_select then
          on_select(full_path)
        end
        -- You can also return or use the filename here
      end)
      return true
    end,
  }):find()
end

return M
