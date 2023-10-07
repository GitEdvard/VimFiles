local M = {}

local find_project_path = function()
  local build_path = vim.fs.find(
  {'build.xml'}, 
  { upward = true, path = vim.fs.dirname(vim.api.nvim_buf_get_name(0)) })
  build_path = build_path[1]
  return vim.fs.dirname(build_path)
end

local get_run_dir = function()
    local project_path = find_project_path()
    return  project_path .. "\\" .. "run" .. "\\" .. os.date("%Y%m%d-%H%M%S")
end

M.launch = function()
  local launch_cmd = [[
C:\ProgramData\NX_BASE\NX12\GLOBAL\APPS\YAPP\jre8\bin\javaw.exe -Xms512m -Xmx1024m -Declipse.p2.data.area=@config.dir\p2 -Declipse.pde.launch=true -Dyapp.rt.class=i290.cmm.Application -Dyapp.rt.gui=false -Dyapp.rt.runner=i290.cmm.internal.Runner -Dyapp.rt.plm.env=P40 -Dyapp.rt.eclipse=true -DOP=MEABL -Dlibrary.distribution.developer_output_dir=C:\Temp\library_distribution -DMC=ZDMXGM -DJOBID=544321688 -Dyapp.rt.class.bundle.symbolicname=i290.cmm -Dyapp.rt.class.bundle.version=1.0.23.qualifier -Dyapp.rt.pfile.path=C:\Users\yh6032\git\i290.manufacturing\i290.manufacturing\i290.cmm\parameter-files\edvard2-cmm.indata -Dfile.encoding=UTF-8 -classpath C:\Users\yh6032\yappclipse\plugins\org.eclipse.equinox.launcher_1.4.0.v20161219-1356.jar org.eclipse.equinox.launcher.Main -application yapp.application -data C:\Users\yh6032\yapp\workspace-oxygen/../yapp-launcher-runtime-ws -configuration file:C:/Users/yh6032/yapp/workspace-oxygen/.metadata/.plugins/org.eclipse.pde.core/Application-Runner-edvard2-cmm/ -dev file:C:/Users/yh6032/yapp/workspace-oxygen/.metadata/.plugins/org.eclipse.pde.core/Application-Runner-edvard2-cmm/dev.properties -os win32 -ws win32 -arch x86_64 -nl en_US -consoleLog
]]
  M.create_new_run_dir()
  local cmd = "cd " .. get_run_dir() .. " && " .. launch_cmd
  require'trigger-commands'.run_single( cmd )
end

M.luanch2 = function()
  local pfile = "C:/Users/yh6032/git/i290.manufacturing/i290.manufacturing/i290.cmm/parameter-files/edvard2-cmm.indata"
  local cfile = "C:/Users/yh6032/yapp/workspace-oxygen/.metadata/.plugins/org.eclipse.pde.core/Application-Runner-edvard2-cmm/"
  local dev_file = "C:/Users/yh6032/yapp/workspace-oxygen/.metadata/.plugins/org.eclipse.pde.core/Application-Runner-edvard2-cmm/dev.properties"
  local class = "i290.cmm.Application"
  local runner = "i290.cmm.internal.Runner"
  local symbolic_name = "i290.cmm"
  local version = "1.0.19.qualifier"
  local launch_cmd = [[
  C:\ProgramData\NX_BASE\NX12\GLOBAL\APPS\YAPP\jre8\bin\javaw.exe -Xms512m -Xmx1024m -Declipse.p2.data.area=@config.dir\p2 -Declipse.pde.launch=true -Dyapp.rt.class=${class} -Dyapp.rt.gui=false -Dyapp.rt.runner=${runner} -Dyapp.rt.plm.env=P40 -Dyapp.rt.eclipse=true -DOP=MEABL -Dlibrary.distribution.developer_output_dir=C:\Temp\library_distribution -DMC=ZDMXGM -DJOBID=544321688 -Dyapp.rt.class.bundle.symbolicname=${symbolic_name} -Dyapp.rt.class.bundle.version=${version} -Dyapp.rt.pfile.path=${pfile} -Dfile.encoding=UTF-8 -classpath C:\Users\yh6032\yappclipse\plugins\org.eclipse.equinox.launcher_1.4.0.v20161219-1356.jar org.eclipse.equinox.launcher.Main -application yapp.application -data C:\Users\yh6032\yapp\workspace-oxygen/../yapp-launcher-runtime-ws -configuration file:${cfile} -dev file:${dev_file} -os win32 -ws win32 -arch x86_64 -nl en_US -consoleLog
]]
  launch_cmd = launch_cmd:gsub("${pfile}", pfile)
  launch_cmd = launch_cmd:gsub("${cfile}", cfile)
  launch_cmd = launch_cmd:gsub("${dev_file}", dev_file)
  launch_cmd = launch_cmd:gsub("${class}", class)
  launch_cmd = launch_cmd:gsub("${runner}", runner)
  launch_cmd = launch_cmd:gsub("${symbolic_name}", symbolic_name)
  launch_cmd = launch_cmd:gsub("${version}", version)
  M.create_new_run_dir()
  local cmd = "cd " .. get_run_dir() .. " && " .. launch_cmd
  require'trigger-commands'.run_single( cmd )
end

M.create_new_run_dir = function()
    local new_run_dir = get_run_dir()
    vim.cmd("silent !mkdir " .. new_run_dir)
end

return M
