local M = {}

local gather_output = function(data, build_output)
    if not data then
        return build_output
    end
    for _, row in ipairs(data) do
        table.insert(build_output, row)
    end
    return build_output
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

local show_errors = function(build_output)
    local vim_script_arr = to_vim_script_arr(build_output)
    vim.cmd { cmd = 'cgetexpr', args = {vim_script_arr} }
end

M.build = function()
  local command = "dotnet build"
  local build_output = {}
  vim.fn.jobstart(command, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      build_output = gather_output(data, build_output)
    end,
    on_stderr = function(_, data)
      build_output = gather_output(data, build_output)
    end,
    on_exit = function(_, exit_code, _)
      if exit_code ~= 0 then
        print("Build failed. Errors written to quickfix")
        show_errors(build_output)
      else
        print("Build succeeded!")
      end
    end
  })
end

return M
