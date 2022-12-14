-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
-- default keymaps are in
-- ~/sources/admin/VimFiles/plugged/telescope.nvim/lua/telescope/mappings.lua
local actions = require "telescope.actions"

require('telescope').setup {
  defaults = {
      mappings = {
          i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-n>"] = require('telescope.actions').cycle_history_next,
              ["<C-p>"] = require('telescope.actions').cycle_history_prev,
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
vim.keymap.set('n', '<leader>ff', "<cmd>Telescope git_files<cr>", bufopts)
vim.keymap.set('n', '<leader>fg', "<cmd>Telescope live_grep<cr>", bufopts)
vim.keymap.set('n', '<leader>fb', "<cmd>Telescope buffers<cr>", bufopts)
vim.keymap.set('n', '<leader>fd', "<cmd>Telescope diagnostics<cr>", bufopts)
vim.keymap.set('n', '<leader>fs', ":Telescope grep_string search=", bufopts)
vim.keymap.set('n', '<leader>fl', "<cmd>Telescope lsp_document_symbols<cr>", bufopts)
vim.keymap.set('n', '<leader>fr', "<cmd>Telescope file_browser<cr>", bufopts)
vim.keymap.set('n', '<leader>yk', "<cmd>Telescope keymaps<cr>", bufopts)
vim.keymap.set('n', '<leader>yr', "<cmd>Telescope registers<cr>", bufopts)
vim.keymap.set('n', '<leader>yc', "<cmd>Telescope command_history<cr>", bufopts)
vim.keymap.set('n', '<leader>yh', "<cmd>Telescope help_tags<cr>", bufopts)
