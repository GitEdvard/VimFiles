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

local expand_execute = function (command, strToExpand, replaceFrom, replaceTo)
  replaceFrom = replaceFrom or nil
  replaceTo = replaceTo or nil
  local expandedStr = vim.fn.expand(strToExpand)
  local lines = mysplit(expandedStr, "\n")
  for _, v in ipairs(lines) do
    if not (replaceFrom == nil) then
      v, _  = v:gsub(replaceFrom, replaceTo)
    end
    vim.cmd(transpose(command, v))
  end
end

-- Expand strToExpand, and find all paths. Call command, second occurance is instead replaced with secondArg
local expand_execute_mult = function (command, strToExpand, secondArg)
  local expandedStr = vim.fn.expand(strToExpand)
  local lines = mysplit(expandedStr, "\n")
  for _, v in ipairs(lines) do
    local parts = mysplit(v, "\\")
    table.remove(parts, #parts)
    local folder = table.concat(parts, "\\")
    secondArg = folder .. "\\".. secondArg
    vim.cmd(transpose2(command, v, secondArg))
  end
end

M.test = function()
  -- expand_execute("Git update-index --assume-unchanged {}", "*/.project")
  -- local cmd = "mycommand {}"
  -- print(transpose(cmd, "hej"))
  -- local cmd2 = "cmd2 {} middle {}"
  -- print(transpose(cmd2, "hejdaa"))
end

M.hide_jdtls_files = function()
  print("Prepare to use jdtls server ...")
  vim.cmd("Git update-index --assume-unchanged .project")
  vim.cmd("!move /y pom.xml pom.xmlX")
  vim.cmd("Git update-index --assume-unchanged pom.xml")
  expand_execute("Git update-index --assume-unchanged {}", "*/.project")
  expand_execute("Git update-index --assume-unchanged {}", "*/pom.xml")
  expand_execute("!move /y {} {}X", "*/pom.xml")
  print("Done")
end

M.unhide_jdtls_files = function()
  print("Restore files after jdtls usage ...")
  expand_execute("Git update-index --no-assume-unchanged {}", "*/.project")
  expand_execute("Git update-index --no-assume-unchanged {}", "*/pom.xmlX", "pom.xmlX", "pom.xml")
  expand_execute("Git checkout HEAD -- {}", "*/.project")
  expand_execute("Git checkout HEAD -- {}", "*/pom.xmlX", "pom.xmlX", "pom.xml")
  vim.cmd("Git update-index --no-assume-unchanged .project")
  vim.cmd("Git checkout HEAD -- .project")
  vim.cmd("Git checkout HEAD -- pom.xml")
  print("Done")
end

function mysplit (inputstr, sep)
  if sep == nil then
          sep = "%s"
  end
  local t={}
  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
          table.insert(t, str)
  end
  return t
end

return M
