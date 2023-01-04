-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<leader>ie', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>w', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gs', vim.lsp.buf.definition, bufopts)
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

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}
-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('lspconfig')['pyright'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities
}
local pid = vim.fn.getpid()
local omnisharp_bin = "/home/edvard/.cache/omnisharp-vim/omnisharp-roslyn/run"
-- local omnisharp_bin = "/mnt/c/Users/edeng655/AppData/Local/omnisharp-vim/omnisharp-rosly/OmniSharp.exe"
require('lspconfig')['omnisharp'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) }
}
require('mycmp_settings')

require('lint').linters_by_ft = {
    python = {'pylint',}
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
        require("lint").try_lint()
    end,
})
