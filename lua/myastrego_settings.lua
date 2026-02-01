local L = require'python.launch_post_analysis'
local R = require'myrun_configs_astrego'
local S = require'python.mypythonlsp'
local Q = require'mylualine.mystatusline'
local T = require'telescope.prefixed_picker'
local U = require'python.my_utils'
local V = require'python.nodes_on_row'
local remapping = require'remapping'

local print_colors = function()
  local custom_theme = require('lualine.themes.auto')
  P(custom_theme)
end

local print_message = function()
  local text = U.fetch_text_at_cursor()
  print("text: "..text)
end

local show_method_definitions_caret = function()
  vim.cmd("normal! m'")
  S.show_method_definitions_caret()
end

local show_usages_caret = function()
  vim.cmd("normal! m'")
  S.show_usages_caret()
end

local show_method_usages = function()
  vim.cmd("normal! m'")
  S.show_method_usages()
end


local show_method_definitions = function()
  vim.cmd("normal! m'")
  S.show_method_definitions()
end

local show_class_family = function()
  vim.cmd("normal! m'")
  S.show_class_family()
end

local goto_superclass = function()
  vim.cmd("normal! m'")
  S.goto_superclass()
end

local show_subclasses = function()
  vim.cmd("normal! m'")
  S.show_subclasses()
end


local opts = { noremap = true, silent = true }
vim.keymap.set('n', 's', remapping.remap_s)
vim.keymap.set('n', '<leader>uk', L.launch, opts)
vim.keymap.set('n', '<leader>ul', L.launch_latest, opts)
vim.keymap.set('n', '<leader>ur', R.list_configs, bufopts)
vim.keymap.set('n', '<leader>uo', L.open_latest, bufopts)
vim.keymap.set('n', '<leader>up', L.open_latest_in_nvim, bufopts)
vim.keymap.set('n', '<leader>iu', goto_superclass, bufopts)
vim.keymap.set('n', '<leader>iU', show_class_family, bufopts)
vim.keymap.set('n', '<leader>im', show_method_definitions, bufopts)
vim.keymap.set('n', '<leader>iM', show_method_usages, bufopts)
vim.keymap.set('n', '<leader>uc', R.create_config, bufopts)
vim.keymap.set('n', '<leader>ik', show_method_definitions_caret, bufopts)
vim.keymap.set('n', '<leader>iK', show_usages_caret, bufopts)
vim.keymap.set('n', '<leader>il', S.show_latest_method_search, bufopts)
-- vim.keymap.set('n', '<leader>ic', T.prefixed_live_grep, bufopts)
vim.keymap.set('n', '<leader>ic', show_subclasses, bufopts)
vim.keymap.set('n', '<leader>kK', Q.evaluate_statusline, bufopts)
vim.keymap.set('n', '<leader>kkb', Q.statusline_len, bufopts)
vim.keymap.set('n', '<leader>kkc', Q.internal_statusline, bufopts)
vim.keymap.set('n', '<leader>kkd', Q.print_components, bufopts)
vim.keymap.set('n', '<leader>ut', S.show_class_instantiation, bufopts)
vim.keymap.set('n', '<leader>kc', S.goto_next_class, bufopts)
vim.keymap.set('n', '<leader>kC', S.goto_previous_class, bufopts)

vim.keymap.set('n', '<leader>kb', remapping.goto_next_bracket, bufopts)
vim.keymap.set('n', '<leader>kB', remapping.goto_previous_bracket, bufopts)
-- vim.keymap.set('n', '<leader>ut', V.nodes_on_line, bufopts)
-- vim.keymap.set("n", "<leader>ic", prefixed_live_grep, { desc = "Live grep for class <name>" })

