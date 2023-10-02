local Job = require("plenary.job")
local M = {}

local transpose = function (aStr, injectStr)
  ret, _ = string.gsub(aStr, "{}", injectStr)
  return ret
end

local transpose2 = function (aStr, injectStr, secondArg)
  local first, _ = string.gsub(aStr, "{}", injectStr, 1)
  local ret, _ = string.gsub(first, "{}", secondArg)
  return ret
end

local expand_execute_sync = function (command, strToExpand)
  local expandedStr = vim.fn.expand(strToExpand)
  local lines = mysplit(expandedStr, "\n")
  for _, v in ipairs(lines) do
    vim.cmd(transpose(command, v))
  end
end

local expand_execute = function (command, strToExpand, commands)
  local expandedStr = vim.fn.expand(strToExpand)
  local lines = mysplit(expandedStr, "\n")
  for _, v in ipairs(lines) do
    table.insert(commands, transpose(command, v))
  end
  return commands
end

-- Expand strToExpand, and find all paths. Call command, second occurance is instead replaced with secondArg
local expand_execute_mult_sync = function (command, strToExpand, secondArg)
  local expandedStr = vim.fn.expand(strToExpand)
  local lines = mysplit(expandedStr, "\n")
  for _, v in ipairs(lines) do
    local parts = mysplit(v, "\\")
    table.remove(parts, #parts)
    local folder = table.concat(parts, "\\")
    local destPath = folder .. "\\".. secondArg
    vim.cmd(transpose2(command, v, destPath))
  end
end

-- Expand strToExpand, and find all paths. Call command, second occurance is instead replaced with secondArg
local expand_execute_mult = function (command, strToExpand, secondArg, commands)
  local expandedStr = vim.fn.expand(strToExpand)
  local lines = mysplit(expandedStr, "\n")
  for _, v in ipairs(lines) do
    local parts = mysplit(v, "\\")
    table.remove(parts, #parts)
    local folder = table.concat(parts, "\\")
    local destPath = folder .. "\\".. secondArg
    table.insert(commands, transpose2(command, v, destPath))
  end
  return commands
end

M.test = function()
  local commands = {}
  local build_path = vim.fs.find(
  {'build.xml'}, 
  { upward = true, path = vim.fs.dirname(vim.api.nvim_buf_get_name(0)) })
  build_path = build_path[1]
  P(build_path)
  local cmd = "ant build-refprojects -f " .. build_path
  require'trigger-commands'.run_silent{cmd}
end

M.update_branch = function(new_branch)
  local pwd = vim.fn.getcwd()
  if pwd:find(vim.g.i290_wt_keyword) then
    local cmd = "ant -f " .. vim.g.nvim_adapt_root .. "/build.xml deploy-target-branch -Dtarget_branch=" .. new_branch
    require'trigger-commands'.run_silent{ cmd, "Deploy nvim adaptation finished", "Deploy nvim adaptation failed"}
  else
    local cmd = "ant -f " .. vim.g.nvim_adapt_root .. "/build.xml deploy"
    require'trigger-commands'.run_silent{ cmd, "Deploy nvim adaptation finished", "Deploy nvim adaptation failed"}
  end
end

M.clean = function()
  local commands = {}
  local build_path = vim.fs.find(
  {'build.xml'}, 
  { upward = true, path = vim.fs.dirname(vim.api.nvim_buf_get_name(0)) })
  build_path = build_path[1]
  P(build_path)
  local cmd = "ant clean -f " .. build_path
  require'trigger-commands'.run_silent{cmd, "Clean completed", "Clean failed"}
end

M.test_multi_line = function()
  local cmd = [[echo "hello1"
  echo "hello2"]]
  require'trigger-commands'.run_single( cmd )
end

M.hide_jdtls_files_sync = function()
  print("Prepare to use jdtls server ...")
  vim.cmd("Git update-index --assume-unchanged .project")
  vim.cmd("Git update-index --assume-unchanged pom.xml")
  -- vim.cmd("!copy /y i290.cmm\\tom.xml i290.cmm\\pom.xml")
  expand_execute_sync("Git update-index --assume-unchanged {}", "*/.project")
  expand_execute_sync("Git update-index --assume-unchanged {}", "*/pom.xml")
  expand_execute_sync("Git update-index --assume-unchanged {}", "*/.classpath")
  expand_execute_sync("Git update-index --assume-unchanged {}", "*/.settings/org.eclipse.jdt.core.prefs")
  vim.cmd("!copy /y tom.xml pom.xml")
  expand_execute_mult_sync("!copy /y {} {}", "*/tom.xml", "pom.xml")
  print("Done")
end

M.unhide_jdtls_files_sync = function()
  print("Restore files after jdtls usage ...")
  expand_execute_sync("Git update-index --no-assume-unchanged {}", "*/.project")
  expand_execute_sync("Git update-index --no-assume-unchanged {}", "*/pom.xml")
  expand_execute_sync("Git update-index --no-assume-unchanged {}", "*/.classpath")
  expand_execute_sync("Git update-index --no-assume-unchanged {}", "*/.settings/org.eclipse.jdt.core.prefs")
  expand_execute_sync("Git checkout HEAD -- {}", "*/.project")
  expand_execute_sync("Git checkout HEAD -- {}", "*/.classpath")
  expand_execute_sync("Git checkout HEAD -- {}", "*/.settings/org.eclipse.jdt.core.prefs")
  expand_execute_sync("Git checkout HEAD -- {}", "*/pom.xml")
  vim.cmd("Git update-index --no-assume-unchanged .project")
  vim.cmd("Git checkout HEAD -- .project")
  vim.cmd("Git update-index --no-assume-unchanged pom.xml")
  vim.cmd("Git checkout HEAD -- pom.xml")
  print("Done")
end

M.hide_jdtls_files = function()
  print("Prepare to use jdtls server ...")
  local commands = {}
  table.insert(commands, "git update-index --assume-unchanged .project")
  table.insert(commands, "git update-index --assume-unchanged pom.xml")
  commands = expand_execute("git update-index --assume-unchanged {}", "*/.project", commands)
  commands = expand_execute("git update-index --assume-unchanged {}", "*/pom.xml", commands)
  commands = expand_execute("git update-index --assume-unchanged {}", "*/.classpath", commands)
  commands = expand_execute("git update-index --assume-unchanged {}", "*/.settings/org.eclipse.jdt.core.prefs", commands)
  table.insert(commands, "copy /y tom.xml pom.xml")
  commands = expand_execute_mult("copy /y {} {}", "*/tom.xml", "pom.xml", commands)
  require'trigger-commands'.run_multi( commands )
  print("Done")
end

M.hide_jdtls_files_new = function()
  print("Prepare to use jdtls server ...")
  local commands = {}
  table.insert(commands, "git update-index --skip-worktree .project")
  table.insert(commands, "git update-index --skip-worktree pom.xml")
  commands = expand_execute("git update-index --skip-worktree {}", "*/.project", commands)
  commands = expand_execute("git update-index --skip-worktree {}", "*/pom.xml", commands)
  commands = expand_execute("git update-index --skip-worktree {}", "*/.classpath", commands)
  commands = expand_execute("git update-index --skip-worktree {}", "*/.settings/org.eclipse.jdt.core.prefs", commands)
  table.insert(commands, "copy /y tom.xml pom.xml")
  commands = expand_execute_mult("copy /y {} {}", "*/tom.xml", "pom.xml", commands)
  require'trigger-commands'.run_multi( commands )
  print("Done")
end

M.unhide_jdtls_files = function()
  print("Restore files after jdtls usage ...")
  local commands = {}
  commands = expand_execute("git update-index --no-assume-unchanged {}", "*/.project", commands)
  commands = expand_execute("git update-index --no-assume-unchanged {}", "*/pom.xml", commands)
  commands = expand_execute("git update-index --no-assume-unchanged {}", "*/.classpath", commands)
  commands = expand_execute("git update-index --no-assume-unchanged {}", "*/.settings/org.eclipse.jdt.core.prefs", commands)
  commands = expand_execute("git checkout HEAD -- {}", "*/.project", commands)
  commands = expand_execute("git checkout HEAD -- {}", "*/.classpath", commands)
  commands = expand_execute("git checkout HEAD -- {}", "*/.settings/org.eclipse.jdt.core.prefs", commands)
  commands = expand_execute("git checkout HEAD -- {}", "*/pom.xml", commands)
  table.insert(commands, "git update-index --no-assume-unchanged .project")
  table.insert(commands, "git checkout HEAD -- .project")
  table.insert(commands, "git update-index --no-assume-unchanged pom.xml")
  table.insert(commands, "git checkout HEAD -- pom.xml")
  require'trigger-commands'.run_multi( commands )
  print("Done")
end

M.unhide_jdtls_files_new = function()
  print("Restore files after jdtls usage ...")
  local commands = {}
  commands = expand_execute("git update-index --no-skip-worktree {}", "*/.project", commands)
  commands = expand_execute("git update-index --no-skip-worktree {}", "*/pom.xml", commands)
  commands = expand_execute("git update-index --no-skip-worktree {}", "*/.classpath", commands)
  commands = expand_execute("git update-index --no-skip-worktree {}", "*/.settings/org.eclipse.jdt.core.prefs", commands)
  commands = expand_execute("git checkout HEAD -- {}", "*/.project", commands)
  commands = expand_execute("git checkout HEAD -- {}", "*/.classpath", commands)
  commands = expand_execute("git checkout HEAD -- {}", "*/.settings/org.eclipse.jdt.core.prefs", commands)
  commands = expand_execute("git checkout HEAD -- {}", "*/pom.xml", commands)
  table.insert(commands, "git update-index --no-skip-worktree .project")
  table.insert(commands, "git checkout HEAD -- .project")
  table.insert(commands, "git update-index --no-skip-worktree pom.xml")
  table.insert(commands, "git checkout HEAD -- pom.xml")
  require'trigger-commands'.run_multi( commands )
  print("Done")
end

M.build = function()
  local commands = {}
  local build_path = vim.fs.find(
  {'build.xml'}, 
  { upward = true, path = vim.fs.dirname(vim.api.nvim_buf_get_name(0)) })
  build_path = build_path[1]
  P(build_path)
  local cmd = "ant build-eclipse-compiler -f " .. build_path
  require'trigger-commands'.run_silent{cmd}
end

M.build_all = function()
  local cmd = "ant build-all"
  require'trigger-commands'.run_silent{cmd, "build all completed", "build all failed, errors written to quickfix"}
end

M.clean_all = function()
  local cmd = "ant clean-all"
  require'trigger-commands'.run_silent{cmd, "clean all completed", "clean all failed"}
end

M.delete_java_files = function ()
  local pwd = vim.fn.getcwd()
  local cmd = ""
  if pwd:find(vim.g.i290_wt_keyword) then
    vim.cmd("let g:fugitive_response = FugitiveHead()")
    cmd = "ant delete-wt-java-files -Dcurrent_branch=" .. vim.g.fugitive_response .. " -Djava_files=" .. vim.g.java_files_base
    print("cmd: " .. cmd)
  else
    cmd = "ant delete-java-files"
  end
  require'trigger-commands'.run_silent{cmd, "Deleting java_files dir completed", "Deleteing java_files dir failed"}
end

M.no_assume_unchanged = function ()
  local cmd = "ant no-assume-unchanged"
  require'trigger-commands'.run_silent{cmd, "git no-assume-unchanged completed", "git no-assume-unchanged failed"}
end

M.assume_unchanged = function ()
  local cmd = "ant assume-unchanged"
  require'trigger-commands'.run_silent{cmd, "git assume-unchanged completed", "git assume-unchanged failed"}
end

M.reset = function()
    package.loaded['java.mysandvik_settings'] = nil
    package.loaded['java.prepare_jdtls'] = nil
    print("mysandvik_settings and prepare_jdtls has been reset!")
end

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

return M
