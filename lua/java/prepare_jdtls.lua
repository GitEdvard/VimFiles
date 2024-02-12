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

M.generate_update_branch_command = function(new_branch)
  local pwd = vim.fn.getcwd()
  local cmd = ""
  if pwd:find(vim.g.i290_wt_keyword) then
    cmd = "ant -f " .. vim.g.nvim_adapt_root .. "/build.xml deploy-target-branch -Dtarget_branch=" .. new_branch
  else
    cmd = "ant -f " .. vim.g.nvim_adapt_root .. "/build.xml deploy"
  end
  return cmd
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

local generate_hide_commands = function()
  local commands = {}
  table.insert(commands, "git update-index --skip-worktree .project")
  table.insert(commands, "git update-index --skip-worktree pom.xml")
  commands = expand_execute("git update-index --skip-worktree {}", "*/.project", commands)
  commands = expand_execute("git update-index --skip-worktree {}", "*/pom.xml", commands)
  commands = expand_execute("git update-index --skip-worktree {}", "*/.classpath", commands)
  commands = expand_execute("git update-index --skip-worktree {}", "*/.settings/org.eclipse.jdt.core.prefs", commands)
  table.insert(commands, "copy /y tom.xml pom.xml")
  commands = expand_execute_mult("copy /y {} {}", "*/tom.xml", "pom.xml", commands)
  return commands
end

M.generate_hide_commands_poly = function()
  local bare_commands = generate_hide_commands()
  local poly_commands ={}
  for _, cmd in pairs(bare_commands) do
    local instruction = {"silent", cmd, "copy tom and update index"}
    table.insert(poly_commands, instruction)
  end
  return poly_commands
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

M.delete_java_files = function(branch)
  local pwd = vim.fn.getcwd()
  local cmd = ""
  if pwd:find(vim.g.i290_wt_keyword) then
    cmd = "ant delete-wt-java-files -f " .. vim.g.nvim_adapt_root .. "/root/build.xml -Dcurrent_branch=" .. branch .. " -Djava_files=" .. vim.g.java_files_base
    print("deleted branch: " .. branch)
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

M.copy_reference_files = function()
  local cmd = "ant -f i290.family.test/maintenence/copy_reference_files.xml"
  require'trigger-commands'.run_silent{cmd, "copy_reference_files completed", "copy_reference_files failed"}
end

return M
