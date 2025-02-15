local client = vim.lsp.start_client {
  name = "educationallps",
  cmd =  { "/home/edvard/sources/dev/go/educationallps/educationallsp" },
  on_attach = require'lsp.on_attach'.keymaps,
}

if not client then 
  vim.notify("Hey, you didnt do the client thing good.")
  return 
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.lsp.buf_attach_client(0, client)
  end
})
