local M = {}

local latest_run_dir = ""

local find_project_path = function()
  local build_path = vim.fs.find(
  {'build.xml'}, 
  { upward = true, path = vim.fs.dirname(vim.api.nvim_buf_get_name(0)) })
  build_path = build_path[1]
  return vim.fs.dirname(build_path)
end

local find_root_path = function()
  local build_path = vim.fs.find(
  {'build.xml'}, 
  { upward = true, path = vim.fs.dirname(vim.api.nvim_buf_get_name(0)) })
  build_path = build_path[1]
  local project_path = vim.fs.dirname(build_path)
  return vim.fs.dirname(project_path)
end

local get_version = function()
  local project_path = find_project_path()
  local manifest_file = project_path .. "\\" .. "META-INF" .. "\\" .. "MANIFEST.MF"
  local lines = lines_from(manifest_file)
  local version = ""
  for k, v in pairs(lines) do
    local find_res, b = string.find(v, "Bundle%-Version")
    if v:find("Bundle%-Version:") then
      local version = v:match("Bundle%-Version:%s*(.*)%s*")
      return version
    end
  end
  return nil
end


local get_run_dir = function(project_name)
    -- local project_path = find_project_path()
    local project_path = find_root_path() .. "\\" .. project_name
    local run_dir = project_path .. "\\" .. "run" .. "\\" .. os.date("%Y%m%d-%H%M%S")
    return run_dir
end

local launch_internal = function(project_name, pfile, runner_name, mc, op)
  -- local pfile_path = "C:/Users/yh6032/HOME/git_me/i290.manufacturing/i290.cmm/parameter-files/" .. pfile
  -- local parameter_files = find_project_path() .. "\\parameter-files\\"
  local parameter_files = find_root_path() .. "\\" .. project_name .. "\\parameter-files\\"
  parameter_files = string.gsub(parameter_files, "\\", "/")
  local pfile_path = parameter_files .. pfile
  local cfile_path = "C:/Users/yh6032/HOME/java_files/launcher-dir/"  .. runner_name .. "/"
  local dev_file = cfile_path .. "dev.properties"
  local class = project_name .. ".Application"
  local runner = project_name .. ".internal.Runner"
  local version = get_version()

  local launch_cmd = [[
  C:\ProgramData\NX_BASE\NX12\GLOBAL\APPS\YAPP\jre8\bin\javaw.exe -Xms512m -Xmx1024m -Declipse.p2.data.area=@config.dir\p2 -Declipse.pde.launch=true -Dyapp.rt.class=${class} -Dyapp.rt.gui=false -Dyapp.rt.runner=${runner} -Dyapp.rt.plm.env=P96 -Dyapp.rt.eclipse=true -DOP=${OP} -Dlibrary.distribution.developer_output_dir=C:\Temp\library_distribution -DMC=${MC} -DJOBID=544321688 -Dyapp.rt.class.bundle.symbolicname=${project_name} -Dyapp.rt.class.bundle.version=${version} -Dyapp.rt.pfile.path=${pfile_path} -Dfile.encoding=UTF-8 -classpath C:\Users\yh6032\yappclipse\plugins\org.eclipse.equinox.launcher_1.4.0.v20161219-1356.jar org.eclipse.equinox.launcher.Main -application yapp.application -data C:\Users\yh6032\yapp\workspace-oxygen/../yapp-launcher-runtime-ws -configuration file:${cfile_path} -dev file:${dev_file} -os win32 -ws win32 -arch x86_64 -nl en_US -consoleLog
]]
  launch_cmd = launch_cmd:gsub("${pfile_path}", pfile_path)
  launch_cmd = launch_cmd:gsub("${cfile_path}", cfile_path)
  launch_cmd = launch_cmd:gsub("${dev_file}", dev_file)
  launch_cmd = launch_cmd:gsub("${class}", class)
  launch_cmd = launch_cmd:gsub("${runner}", runner)
  launch_cmd = launch_cmd:gsub("${project_name}", project_name)
  launch_cmd = launch_cmd:gsub("${version}", version)
  launch_cmd = launch_cmd:gsub("${MC}", mc)
  launch_cmd = launch_cmd:gsub("${OP}", op)
  M.create_new_run_dir(project_name)
  local instruction1 = { "silent", "ant clean-all", "clean all" }
  local instruction2 = { "silent", "ant build-all", "build all" }
  local cmd = "cd " .. latest_run_dir .. " && " .. launch_cmd
  local instruction3 = { "hidden-scratch", cmd, { "YappException", "RuntimeException"}, "Launch" }
  local latest_run_catalog = vim.fs.basename(latest_run_dir)
  local instruction4 = { "silent", "ant copy-run-output -Dproject=" .. project_name .. " -Drun_catalog=" .. latest_run_catalog, "copy run to eclipse"}
  local instructions = { instruction1, instruction2, instruction3, instruction4 }
  require'trigger-commands'.run_poly( instructions )
end

M.test_copy = function(settings_file)
  local run_config = require'read-settings'.read_json(settings_file)
  local latest_run_catalog = vim.fs.basename(latest_run_dir)
  local instruction4 = { "silent", "ant copy-run-output -Dproject=" .. run_config.project .. " -Drun_catalog=" .. latest_run_catalog, "copy run to eclipse"}
  local instructions = { instruction4 }
  require'trigger-commands'.run_poly( instructions )
end

M.open_prt = function()
  print("start")
  for file in io.popen("dir " .. latest_run_dir .. [[/b]]):lines() do 
    if string.find(file, ".prt") and not string.find(file, "DA_MANU_") then
      local path = latest_run_dir .. "\\" .. file
      local cmd = "ugs_router.exe -ug -use_file_dir " .. path
      require'trigger-commands'.run_silent{cmd, "Open prt succeeded", "Open prt failed"}
    end
  end
end

M.launch = function(settings_file)
  local run_config = require'read-settings'.read_json(settings_file)
  launch_internal(run_config.project, run_config.pfile, "Application-Runner-edvard2-cmm", run_config.mc, run_config.op)
end

M.get_latest_run_dir = function()
  return latest_run_dir
end

local trigger_command_rest = function()
    require'trigger-commands'.run_rest_call(run_settings)
end

M.create_new_run_dir = function(project_name)
    local new_run_dir = get_run_dir(project_name)
    latest_run_dir = new_run_dir
    vim.cmd("silent !mkdir " .. new_run_dir)
end

M.build = function()
  local commands = {}
  local build_path = vim.fs.find(
  {'build.xml'}, 
  { upward = true, path = vim.fs.dirname(vim.api.nvim_buf_get_name(0)) })
  build_path = build_path[1]
  P(build_path)
  local cmd = "ant build-this-project -f " .. build_path
  require'trigger-commands'.run_silent{cmd}
end

M.build_all = function()
  local cmd = "ant build-all"
  require'trigger-commands'.run_silent{cmd, "build all completed", "build all failed, errors written to quickfix"}
end

M.clean_and_build_all = function()
  local instruction1 = { "silent", "ant clean-all", "clean all" }
  local instruction2 = { "silent", "ant build-all", "build all" }
  local instructions = { instruction1, instruction2 }
  require'trigger-commands'.run_poly( instructions )
end

return M
