local build = function()
  local cmd = [[
C:\ProgramData\NX_BASE\NX12\GLOBAL\APPS\YAPP\jre8\bin\javaw.exe -Xms512m -Xmx1024m -Declipse.p2.data.area=@config.dir\p2 -Declipse.pde.launch=true -Dyapp.rt.class=i290.cmm.Application -Dyapp.rt.gui=false -Dyapp.rt.runner=i290.cmm.internal.Runner -Dyapp.rt.plm.env=P40 -Dyapp.rt.eclipse=true -Dyapp.rt.class.bundle.symbolicname=i290.cmm -Dyapp.rt.class.bundle.version=1.0.11.qualifier -Dyapp.rt.pfile.path=C:\Users\yh6032\git\i290.manufacturing\i290.manufacturing\i290.cmm\parameter-files\edvard-cmm.indata -Dfile.encoding=UTF-8 -classpath C:\Users\yh6032\yappclipse\plugins\org.eclipse.equinox.launcher_1.4.0.v20161219-1356.jar org.eclipse.equinox.launcher.Main -application yapp.application -data C:\Users\yh6032\yapp\workspace-oxygen/../yapp-launcher-runtime-ws -configuration file:C:/Users/yh6032/yapp/workspace-oxygen/.metadata/.plugins/org.eclipse.pde.core/Application-Runner-edvard-cmm/ -dev file:C:/Users/yh6032/yapp/workspace-oxygen/.metadata/.plugins/org.eclipse.pde.core/Application-Runner-edvard-cmm/dev.properties -os win32 -ws win32 -arch x86_64 -nl en_US -consoleLog
]]
  require'trigger-commands'.run_single( cmd )
end

local start_yapp = function()
  -- vim.cmd("let $PATH=C:\Program files\siemens\nx12\NXBIN;%PATH%")
  local cmd_yapp = [[
C:\Users\yh6032\yappclipse\yapp.exe -debug -consoleLog
  ]]
  require'trigger-commands'.run_single( cmd_yapp )
end
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>uy', start_yapp, opts)
vim.keymap.set('n', '<leader>ub', build, opts)
