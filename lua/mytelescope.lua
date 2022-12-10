-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
require('telescope').setup {
  defaults = {
      mappings = {
          i = {
---              ["<C-n>"] = actions.move_selection_next,
---              ["<C-p>"] = actions.move_selection_previous,
          }
      }
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')
require("telescope").load_extension "file_browser"

local M = {}
function M.current_buffer_fuzzy_find()
    local opts = {}
    opts.prompt_prefix = '$ '
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_ivy(opts))
end
local bufopts = { noremap=true, silent=true }
vim.keymap.set('n', '<leader>fe', M.current_buffer_fuzzy_find, bufopts)
