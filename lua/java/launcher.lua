local M = {}

local find_project_path = function()
  local build_path = vim.fs.find(
  {'build.xml'}, 
  { upward = true, path = vim.fs.dirname(vim.api.nvim_buf_get_name(0)) })
  build_path = build_path[1]
  return vim.fs.dirname(build_path)
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


local get_run_dir = function()
    local project_path = find_project_path()
    return  project_path .. "\\" .. "run" .. "\\" .. os.date("%Y%m%d-%H%M%S")
end

local launch_internal = function(project_name, pfile, runner_name, mc, op)
  local pfile_path = "C:/Users/yh6032/HOME/git_me/i290.manufacturing/i290.cmm/parameter-files/" .. pfile
  local cfile_path = "C:/Users/yh6032/HOME/java_files/launcher-dir/"  .. runner_name .. "/"
  local dev_file = cfile_path .. "dev.properties"
  local class = project_name .. ".Application"
  local runner = project_name .. ".internal.Runner"
  local version = get_version()

  local launch_cmd = [[
  C:\ProgramData\NX_BASE\NX12\GLOBAL\APPS\YAPP\jre8\bin\javaw.exe -Xms512m -Xmx1024m -Declipse.p2.data.area=@config.dir\p2 -Declipse.pde.launch=true -Dyapp.rt.class=${class} -Dyapp.rt.gui=false -Dyapp.rt.runner=${runner} -Dyapp.rt.plm.env=P40 -Dyapp.rt.eclipse=true -DOP=${OP} -Dlibrary.distribution.developer_output_dir=C:\Temp\library_distribution -DMC=${MC} -DJOBID=544321688 -Dyapp.rt.class.bundle.symbolicname=${project_name} -Dyapp.rt.class.bundle.version=${version} -Dyapp.rt.pfile.path=${pfile_path} -Dfile.encoding=UTF-8 -classpath C:\Users\yh6032\yappclipse\plugins\org.eclipse.equinox.launcher_1.4.0.v20161219-1356.jar org.eclipse.equinox.launcher.Main -application yapp.application -data C:\Users\yh6032\yapp\workspace-oxygen/../yapp-launcher-runtime-ws -configuration file:${cfile_path} -dev file:${dev_file} -os win32 -ws win32 -arch x86_64 -nl en_US -consoleLog
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
  M.create_new_run_dir()
  local cmd = "cd " .. get_run_dir() .. " && " .. launch_cmd
  require'trigger-commands'.run_single( cmd )
end

M.launch = function()
  launch_internal("i290.cmm", "gge-mea.indata", "Application-Runner-edvard2-cmm", "Zeiss_Fortis_Calypso_2023", "GGE")
end

M.create_new_run_dir = function()
    local new_run_dir = get_run_dir()
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

M.clean_all = function()
  local cmd = "ant clean-all"
  require'trigger-commands'.run_silent{cmd, "clean all completed", "clean all failed"}
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

return M
