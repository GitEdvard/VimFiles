local M = {}

M.keymaps = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gs', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gt', '<cmd>tab split | lua vim.lsp.buf.definition()<cr>', bufopts)
  vim.keymap.set('n', '<leader>ih', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<leader>ii', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<leader>is', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>iwa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>iwr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>iwl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<leader>iD', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>in', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ia', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<leader>ir', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>if', function() vim.lsp.buf.format { async = true } end, bufopts)
end

return M
