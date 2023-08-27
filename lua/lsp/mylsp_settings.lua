-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<leader>ie', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>w', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}
-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local on_attach = require'lsp.on_attach'.keymaps

require('mycmp_settings')
require'lsp.angular'
require'lsp.csharp'.setup(lsp_flags, capabilities, on_attach)
require'lsp.python'.setup(lsp_flags, capabilities, on_attach)
vim.diagnostic.config({

})
-- require'lsp.java_lspconfig'.setup(lsp_flags, capabilities, on_attach)

require('lint').linters_by_ft = {
    python = {'pylint',}
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
        require("lint").try_lint()
    end,
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    signs = {
      severity_limit = "Warning",
    },
    virtual_text = {
      severity_limit = "Warning",
    },
  }
)
