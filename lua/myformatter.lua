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
          args = { "-noSplash", "-vm", vim.g.java_vm, "-data", vim.g.java_files_tmp, "-application", "org.eclipse.jdt.core.JavaCodeFormatter", "-config", vim.g.java_format_config },
          stdin = false
        }
      end,
    },
  },
})
