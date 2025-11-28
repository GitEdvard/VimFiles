local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local Job = require("plenary.job")

local M = {}

local ecwd = vim.fn.getcwd()

M.prefixed_live_grep = function()
  pickers.new({}, {
    prompt_title = "Search for class",
    finder = finders.new_job(function(prompt)
      if not prompt or prompt == "" then
        return nil
      end
      local search_term = "class " .. prompt .. " " .. ecwd
      return Job:new({
        command = "rg",
        args = {
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "-w",
          search_term,
          cwd,
        },
        on_stdout = function(_, line)
          return line
        end,
      })
    end, {}),
    sorter = conf.generic_sorter({}),
  }):find()
end

return M

