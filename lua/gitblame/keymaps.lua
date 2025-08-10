vim.api.nvim_create_autocmd("FileType", {
  pattern = {"fugitiveblame"},
  callback = function()
    vim.schedule(function()
      vim.keymap.set("n", "q", ":bd<cr>", {buffer = true})
    end)
  end,
})

