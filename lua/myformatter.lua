local util = require "formatter.util"

require'formatter'.setup({
  logging = true,
  log_level = vim.log.levels.INFO,
  filetype = {
    java = {
      function()
        return {
          exe = "eclipsec.exe",
          -- Formatter uses '-' as stdin
          args = { "-noSplash", "-vm", "C:\\ProgramData\\NX_BASE\\NX12\\GLOBAL\\APPS\\YAPP\\jre8\\bin\\javaw.exe", "-data", "C:\\Users\\yh6032\\HOME\\java_files\\tmp", "-application", "org.eclipse.jdt.core.JavaCodeFormatter", "-config", "C:\\Users\\yh6032\\HOME\\git_me\\nvim-adapt\\yapp_format.ini", util.get_current_buffer_file_path()},
          stdin = false
        }
      end,
    },
  },
})
