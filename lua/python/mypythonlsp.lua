-- Perhaps put in separate plugin?
local N = {}
local M = require'test_on_save_core'
local Job = require('plenary.job')
local pickers = require "telescope.pickers"
local conf = require("telescope.config").values
local finders = require "telescope.finders"
local make_entry = require "telescope.make_entry"
local latest_search_text = ""
local latest_prefix_text = ""
local latest_filter_text = ""


local query_for_superclass = [[
(
(class_definition
superclasses: (argument_list (identifier) @name))
)
]]

local query_for_class = [[
(
(class_definition
name: (identifier) @name)
)
]]

local query_for_function = [[
(
(function_definition
name: (identifier) @name)
)
]]

local call_execute_query = function(query_list)
    local bufnr = vim.api.nvim_get_current_buf()
    local search_hit = M.execute_query(bufnr, query_list, "python")
    return search_hit
end

local find_with_rg_from_str = function(search_text)
    local cwd = vim.fn.getcwd()
    grepper = Job:new({
      command = "rg",
      args = {"--vimgrep", "--type", "py", "-w", search_text, cwd},
      cwd = cwd,
    })
    local rg_hits = grepper:sync()
    return rg_hits
end

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


local find_super_class_name = function()
    local query_list = {
        ['class'] = query_for_superclass,
    }
    return call_execute_query(query_list)
end

local find_super_class = function()
    local query_list = {
        ['class'] = query_for_superclass,
    }
    local prefix = "class "
    return find_with_prefix(query_list, prefix)
end

local find_subclasses = function(super_class_name)
    local search_text = "class .*?\\((.* ,)?\\b" ..  super_class_name .."\\b(, .*)?\\)"
    local cwd = vim.fn.getcwd()
    grepper = Job:new({
      command = "rg",
      args = {"--vimgrep", "--type", "py", "-e", search_text, cwd},
      cwd = cwd,
    })
    local rg_hits = grepper:sync()
    local filtered_hits = {}
    for _, value in pairs(rg_hits) do
      -- Match whole word only
      if not value:find("%f[%a]tests%f[%A]") then
        table.insert(filtered_hits, value)
      end
    end
    return filtered_hits
end

find_subclasses_rec = function(root_class, rg_hits)
  local hits = find_subclasses(root_class)
  for _, single_rg_hit in pairs(hits) do
    table.insert(rg_hits, single_rg_hit)
    local class_name = single_rg_hit:match(".*class (.*)%(.*%).*")
    local class_name_trimmed = class_name:gsub("%s+", "")
    find_subclasses_rec(class_name_trimmed, rg_hits)
  end
  return rg_hits
end

local find_sibling_classes = function(query_list)
    local bufnr = vim.api.nvim_get_current_buf()
    local cwd = vim.fn.getcwd()
    local search_hit = M.execute_query(bufnr, query_list, "python")
    if search_hit == "" or search_hit == nil then
      return {}
    end
    local search_text = "class .*?\\((.* ,)?\\b" ..  search_hit .."\\b(, .*)?\\)"
    grepper = Job:new({
      command = "rg",
      args = {"--vimgrep", "--type", "py", "-e", search_text, cwd},
      cwd = cwd,
    })
    local rg_hits = grepper:sync()
    local filtered_hits = {}
    for _, value in pairs(rg_hits) do
      -- Match whole word "def" only
      if not value:find("%f[%a]tests%f[%A]") then
        table.insert(filtered_hits, value)
      end
    end
    return filtered_hits
end

local fetch_text_at_cursor = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local search_hit = M.get_text_at_cursor(bufnr)
    return search_hit
end

local find_with_rg = function(search_text, search_prefix, filter_text)
    if search_text == "" or search_text == nil then
      return {}
    end
    if not (search_prefix == nil) and not (search_prefix == "") then
      search_text = search_prefix .. " " .. search_text
    end
    local cwd = vim.fn.getcwd()
    grepper = Job:new({
      command = "rg",
      args = {"--vimgrep", "--type", "py", "--glob", "!tests", "-w", search_text, cwd},
      cwd = cwd,
    })
    local rg_hits = grepper:sync()
    if filter_text == nil or filter_text == "" then
      return rg_hits
    end
    local filtered_hits = {}
    for _, value in pairs(rg_hits) do
      -- Match whole word "def" only
      if not value:find("%f[%a]"..filter_text.."%f[%A]") then
        table.insert(filtered_hits, value)
      end
    end
    return filtered_hits
end

local find_method_text = function()
    local query_list = {
        ['function'] = query_for_function,
    }
    return call_execute_query(query_list)
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

N.find_current_class_name = function()
    local query_list = {
        ['class'] = query_for_class,
    }
    local bufnr = vim.api.nvim_get_current_buf()
    local cwd = vim.fn.getcwd()
    local search_hit = M.execute_query(bufnr, query_list, "python")
    return search_hit
end

N.find_current_method_name = function()
    local query_list = {
        ['function'] = query_for_function,
    }
    local bufnr = vim.api.nvim_get_current_buf()
    local cwd = vim.fn.getcwd()
    local search_hit = M.execute_query(bufnr, query_list, "python")
    return search_hit
end

N.show_method_definitions = function()
  local method_text = find_method_text()
  local method_definitions = find_with_rg(method_text, "def", "")
  latest_search_text = method_text
  latest_prefix_text = "def"
  latest_filter_text = ""
  show_picker("Find methods", method_definitions)
end

N.show_method_usages = function()
  local method_text = find_method_text()
  local method_usages = find_with_rg(method_text, "", "def")
  latest_search_text = method_text
  latest_prefix_text = ""
  latest_filter_text = "def"
  show_picker("Methods usages", method_usages)
end

N.goto_superclass = function()
  super_class_hits = find_super_class()
  super_class_hits_arr = to_vim_script_arr(super_class_hits)
  vim.cmd { cmd = 'cgetexpr', args = {super_class_hits_arr} }
  vim.cmd { cmd = 'cfirst'}
end

local find_root_super_class_name = function()
  local next_candidate_super_class = find_super_class_name()
  local latest_super_class = ""
  local latest_rg_hits = {}
  local rg_hits = {}
  if next_candidate_super_class ~= nil and next_candidate_super_class ~= "" then
    rg_hits = find_with_rg_from_str("class " .. next_candidate_super_class)
  end
  if #rg_hits == 0 then
    latest_super_class = N.find_current_class_name()
    latest_rg_hits = find_with_rg_from_str("class "..latest_super_class)
  end
  while #rg_hits > 0 do
    latest_super_class = next_candidate_super_class
    latest_rg_hits = rg_hits
    first_rg_hit = rg_hits[1]
    rg_hits = {}
    local within_params = first_rg_hit:match("%((.*)%)")
    local within_params_trimmed = within_params:gsub("%s+", "")
    if not (within_params_trimmed == "") then
      local class_list = mysplit(within_params, ",")
      next_candidate_super_class = class_list[1]
      rg_hits = find_with_rg_from_str("class " .. next_candidate_super_class)
    end
  end
  return latest_super_class, latest_rg_hits
end

N.show_class_family = function()
  local root_super_class_name, rg_hits_for_root = find_root_super_class_name()
  local accumulated_hits = rg_hits_for_root
  find_subclasses_rec(root_super_class_name, accumulated_hits)
  show_picker("Class family", accumulated_hits)
end

N.show_method_usages_caret = function()
  local text_at_cursor = fetch_text_at_cursor()
  local method_usages = find_with_rg(text_at_cursor, "", "def")
  latest_search_text = text_at_cursor
  latest_prefix_text = ""
  latest_filter_text = "def"
  show_picker("Methods usages", method_usages)
end

N.show_method_definitions_caret = function()
  local text_at_cursor = fetch_text_at_cursor()
  local method_definitions = find_with_rg(text_at_cursor, "def", "")
  latest_search_text = text_at_cursor
  latest_prefix_text = "def"
  latest_filter_text = ""
  show_picker("Method definitions", method_definitions)
end

-- remove
N.show_sibbling_classes = function()
    local query_list = {
        ['class'] = query_for_superclass,
    }
  siblings = find_sibling_classes(query_list)
  show_picker("Sibling classes", siblings)
end

N.show_latest_method_search = function()
  local method_definitions = find_with_rg(latest_search_text, latest_prefix_text, latest_filter_text)
  show_picker("Find methods", method_definitions)
end

return N
