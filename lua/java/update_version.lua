local M = {}

M.update_version = function()
  local tmp_file = find_root_path() .. "\\" .. "launch.tmp"
  print(tmp_file)
  local cmd = "C:\\ProgramData\\NX_BASE\\NX12\\GLOBAL\\APPS\\YAPP\\jre8\\bin\\javaw.exe -Dmaven.home=EMBEDDED -Dclassworlds.conf=${tmp_file} -Dmaven.multiModuleProjectDirectory=C:\\ProgramData\\YAPP\\git\\i290.manufacturing -Dfile.encoding=UTF-8 -classpath C:\\Users\\yh6032\\yappclipse\\plugins\\org.eclipse.m2e.maven.runtime_1.8.3.20180227-2135\\jars\\plexus-classworlds-2.5.2.jar org.codehaus.plexus.classworlds.launcher.Launcher -Pversion -B -Dtycho.mode=maven tycho-versions:set-version tycho-versions:update-pom -DnewVersion=${version}"
  cmd = cmd:gsub("${tmp_file}", tmp_file)
  require'trigger-commands'.run_single(cmd)
end


return M
