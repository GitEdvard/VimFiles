local launch = function()
  local commands = {}
  local pwd = vim.fn.getcwd()
  local run_dir = pwd .. "/i290.cmm/run"
  local cd_cmd = "cd " .. run_dir
  local launch_cmd = [[
C:\ProgramData\NX_BASE\NX12\GLOBAL\APPS\YAPP\jre8\bin\javaw.exe -Xms512m -Xmx1024m -Declipse.p2.data.area=@config.dir\p2 -Declipse.pde.launch=true -Dyapp.rt.class=i290.cmm.Application -Dyapp.rt.gui=false -Dyapp.rt.runner=i290.cmm.internal.Runner -Dyapp.rt.plm.env=P40 -Dyapp.rt.eclipse=true -DOP=MEABL -Dlibrary.distribution.developer_output_dir=C:\Temp\library_distribution -DMC=ZDMXGM -DJOBID=544321688 -Dyapp.rt.class.bundle.symbolicname=i290.cmm -Dyapp.rt.class.bundle.version=1.0.23.qualifier -Dyapp.rt.pfile.path=C:\Users\yh6032\git\i290.manufacturing\i290.manufacturing\i290.cmm\parameter-files\edvard2-cmm.indata -Dfile.encoding=UTF-8 -classpath C:\Users\yh6032\yappclipse\plugins\org.eclipse.equinox.launcher_1.4.0.v20161219-1356.jar org.eclipse.equinox.launcher.Main -application yapp.application -data C:\Users\yh6032\yapp\workspace-oxygen/../yapp-launcher-runtime-ws -configuration file:C:/Users/yh6032/yapp/workspace-oxygen/.metadata/.plugins/org.eclipse.pde.core/Application-Runner-edvard2-cmm/ -dev file:C:/Users/yh6032/yapp/workspace-oxygen/.metadata/.plugins/org.eclipse.pde.core/Application-Runner-edvard2-cmm/dev.properties -os win32 -ws win32 -arch x86_64 -nl en_US -consoleLog
]]
  require'trigger-commands'.run_single( cd_cmd .. "&&" .. launch_cmd )
end

local myfnc = function()
  local pfile = "C:/Users/yh6032/git/i290.manufacturing/i290.manufacturing/i290.cmm/parameter-files/edvard2-cmm.indata"
  local cfile = "C:/Users/yh6032/yapp/workspace-oxygen/.metadata/.plugins/org.eclipse.pde.core/Application-Runner-edvard2-cmm/"
  local dev_file = "C:/Users/yh6032/yapp/workspace-oxygen/.metadata/.plugins/org.eclipse.pde.core/Application-Runner-edvard2-cmm/dev.properties"
  local class = "i290.cmm.Application"
  local runner = "i290.cmm.internal.Runner"
  local symbolic_name = "i290.cmm"
  local version = "1.0.19.qualifier"
  local cmd = [[
  C:\ProgramData\NX_BASE\NX12\GLOBAL\APPS\YAPP\jre8\bin\javaw.exe -Xms512m -Xmx1024m -Declipse.p2.data.area=@config.dir\p2 -Declipse.pde.launch=true -Dyapp.rt.class=${class} -Dyapp.rt.gui=false -Dyapp.rt.runner=${runner} -Dyapp.rt.plm.env=P40 -Dyapp.rt.eclipse=true -DOP=MEABL -Dlibrary.distribution.developer_output_dir=C:\Temp\library_distribution -DMC=ZDMXGM -DJOBID=544321688 -Dyapp.rt.class.bundle.symbolicname=${symbolic_name} -Dyapp.rt.class.bundle.version=${version} -Dyapp.rt.pfile.path=${pfile} -Dfile.encoding=UTF-8 -classpath C:\Users\yh6032\yappclipse\plugins\org.eclipse.equinox.launcher_1.4.0.v20161219-1356.jar org.eclipse.equinox.launcher.Main -application yapp.application -data C:\Users\yh6032\yapp\workspace-oxygen/../yapp-launcher-runtime-ws -configuration file:${cfile} -dev file:${dev_file} -os win32 -ws win32 -arch x86_64 -nl en_US -consoleLog
]]
  cmd = cmd:gsub("${pfile}", pfile)
  cmd = cmd:gsub("${cfile}", cfile)
  cmd = cmd:gsub("${dev_file}", dev_file)
  cmd = cmd:gsub("${class}", class)
  cmd = cmd:gsub("${runner}", runner)
  cmd = cmd:gsub("${symbolic_name}", symbolic_name)
  cmd = cmd:gsub("${version}", version)
  require'trigger-commands'.run_single( cmd )
end

local start_yapp = function()
  -- vim.cmd("let $PATH=C:\Program files\siemens\nx12\NXBIN;%PATH%")
  local cmd_yapp = [[
C:\Users\yh6032\yappclipse\yapp.exe -debug -consoleLog
  ]]
  require'trigger-commands'.run_single( cmd_yapp )
end

local M = require'java.prepare_jdtls'
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>uy', start_yapp, opts)
vim.keymap.set('n', '<leader>ul', launch, opts)
vim.keymap.set('n', '<leader>ub', M.build, opts)
vim.keymap.set('n', '<leader>uh', M.hide_jdtls_files, opts)
vim.keymap.set('n', '<leader>uu', M.unhide_jdtls_files, opts)
vim.keymap.set('n', '<leader>ut', M.test, opts)
vim.keymap.set('n', '<leader>ue', M.clean, opts)
vim.keymap.set('n', '<leader>ud', M.delete_java_files, opts)
