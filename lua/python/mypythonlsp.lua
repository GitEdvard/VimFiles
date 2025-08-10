-- Perhaps put in separate plugin?
local N = {}
local M = require'test_on_save_core'
local Job = require('plenary.job')

local query_for_class = [[
(
(class_definition
superclasses: (argument_list (identifier) @name))
)
]]

local find_super_class = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local cwd = vim.fn.getcwd()
    local query_list = {
        ['class'] = query_for_class,
    }
    local super_class_name = M.execute_query(bufnr, query_list, "python")
    if super_class_name == "" or super_class_name == nil then
      return {}
    end
    local search_text = super_class_name
    grepper = Job:new({
      command = "rg",
      args = {"--vimgrep", "--type", "py", "-w", search_text, cwd},
      cwd = cwd,
    })
    local rg_hits = grepper:sync()
    super_class_hits = {}
    for _, single_rg_hit in pairs(rg_hits) do
      P(single_rg_hit)
      if string.find(single_rg_hit, "class ".. search_text .. "%w*") then
        table.insert(super_class_hits, single_rg_hit)
      end
    end
    return super_class_hits
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

N.goto_superclass = function()
  super_class_hits = find_super_class()
  P(super_class_hits)
  super_class_hits_arr = to_vim_script_arr(super_class_hits)
  vim.cmd { cmd = 'cgetexpr', args = {super_class_hits_arr} }
  vim.cmd { cmd = 'cfirst'}
end

return N
