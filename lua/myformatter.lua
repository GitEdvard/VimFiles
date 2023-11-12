require'formatter'.setup({
  logging = true,
  log_level = vim.log.levels.WARN,
  filetype = {
    java = {
      function()
        return {
          exe = "java",
          -- Formatter uses '-' as stdin
          args = { "-jar", "<file>", "-" },
          stdin = true
        }
      end,
    },
  },
})
