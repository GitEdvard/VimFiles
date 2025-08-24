-- Perhaps put in separate plugin?
local N = {}
local M = require'test_on_save_core'
local Job = require('plenary.job')
local pickers = require "telescope.pickers"
local conf = require("telescope.config").values
local finders = require "telescope.finders"
local make_entry = require "telescope.make_entry"


local query_for_class = [[
(
(class_definition
superclasses: (argument_list (identifier) @name))
)
]]

local query_for_function = [[
(
(function_definition
name: (identifier) @name)
)
]]

local find_with_prefix = function(query_list, prefix)
    local bufnr = vim.api.nvim_get_current_buf()
    local cwd = vim.fn.getcwd()
    local search_hit = M.execute_query(bufnr, query_list, "python")
    if search_hit == "" or search_hit == nil then
      return {}
    end
    local search_text = prefix .. search_hit
    grepper = Job:new({
      command = "rg",
      args = {"--vimgrep", "--type", "py", "-w", search_text, cwd},
      cwd = cwd,
    })
    local rg_hits = grepper:sync()
    return rg_hits
end

local find_filtered_for_def = function(query_list)
    local bufnr = vim.api.nvim_get_current_buf()
    local cwd = vim.fn.getcwd()
    local search_hit = M.execute_query(bufnr, query_list, "python")
    if search_hit == "" or search_hit == nil then
      return {}
    end
    local search_text = search_hit
    grepper = Job:new({
      command = "rg",
      args = {"--vimgrep", "--type", "py", "--glob", "!tests", "-w", search_text, cwd},
      cwd = cwd,
    })
    local rg_hits = grepper:sync()
    local filtered_hits = {}
    for _, value in pairs(rg_hits) do
      if not value:find("def") then
        table.insert(filtered_hits, value)
      end
    end
    return filtered_hits
end

local find_method_definitions = function()
    local query_list = {
        ['function'] = query_for_function,
    }
    local prefix = "def "
    return find_with_prefix(query_list, prefix)
end

local find_method_usages = function()
    local query_list = {
        ['function'] = query_for_function,
    }
    return find_filtered_for_def(query_list)
end

local find_super_class = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local cwd = vim.fn.getcwd()
    local query_list = {
        ['class'] = query_for_class,
    }
    local prefix = "class "
    return find_with_prefix(query_list, prefix)
end

local to_vim_script_arr = function(lua_table)
    -- lua table contains strings only. Escape each single quote in it
    local escaped_table = {}
    for _, v in ipairs(lua_table) do
        local row = string.gsub(v, "'", "''")
        table.insert(escaped_table, row)
    end
    return '[\'' .. table.concat(escaped_table, '\',\'') .. '\']'
end

local show_picker = function(title, contents_table)
  local opts = {}
  pickers.new(opts, {
    prompt_title = title,
    finder = finders.new_table {
      results = contents_table,
      entry_maker = opts.entry_maker or make_entry.gen_from_vimgrep(opts)
    },
    previewer = conf.grep_previewer(opts),
    sorter = conf.generic_sorter(opts),
    push_cursor_on_edit = true,
  }):find()
end

N.show_method_definitions = function()
  local method_definitions = find_method_definitions()
  local opts = {}
  show_picker("Find methods", method_definitions)
end

N.show_method_usages = function()
  local method_usages = find_method_usages()
  local opts = {}
  show_picker("Methods usages", method_usages)
end

N.goto_superclass = function()
  super_class_hits = find_super_class()
  super_class_hits_arr = to_vim_script_arr(super_class_hits)
  vim.cmd { cmd = 'cgetexpr', args = {super_class_hits_arr} }
  vim.cmd { cmd = 'cfirst'}
end

return N
