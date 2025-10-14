local fold_for_python = function()
  vim.opt_local.foldmethod = "indent"
  vim.opt_local.foldlevel = 0
end

local fold_for_json = function()
  vim.opt_local.foldmethod = "indent"
  vim.opt_local.foldlevel = 2
end

local opts = { noremap = true, silent = true, buffer = true }

vim.api.nvim_create_autocmd("FileType", {
  pattern = {"python"},
  callback = function()
    vim.schedule(function()
      vim.keymap.set("n", "<leader>kz", fold_for_python, opts)
    end)
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = {"json"},
  callback = function()
    vim.schedule(function()
      vim.keymap.set("n", "<leader>kz", fold_for_json, opts)
    end)
  end,
})

