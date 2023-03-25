local opts = { noremap=true, silent=true }
vim.keymap.set("n", "<F5>", ":lua require'dap'.continue()<cr>", opts)
vim.keymap.set("n", "<F17>", ":lua require'dap'.terminate()<cr>", opts) -- this is S-F5
vim.keymap.set("n", "<F10>", ":lua require'dap'.step_over()<cr>", opts)
vim.keymap.set("n", "<F11>", ":lua require'dap'.step_into()<cr>", opts)
vim.keymap.set("n", "<F23>", ":lua require'dap'.step_out()<cr>", opts) -- this is S-F11
vim.keymap.set("n", "<F9>", ":lua require'dap'.toggle_breakpoint()<cr>", opts)
vim.keymap.set("n", "<F21>", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opts) -- this is S-F9
vim.keymap.set("n", "<F33>", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", opts) -- this is C-F9
vim.keymap.set("n", "<leader>dr", ":lua require'dap'.repl_open()<cr>", opts)
vim.keymap.set("n", "<leader>dl", ":lua require'dap'.run_last()<cr>", opts)
vim.keymap.set("n", "<leader>dt", ":lua require'dap-python'.test_method()<cr>", opts)
vim.keymap.set("n", "<leader>do", ":lua require'dapui'.open()<cr>", opts)
vim.keymap.set("n", "<leader>dc", ":lua require'dapui'.close()<cr>", opts)
vim.keymap.set("n", "<leader>di", ":lua require('dap.ui.widgets').hover()<cr>", opts)
vim.keymap.set("n", "<leader>dh", "<cmd>Telescope dap commands<cr>", opts)
vim.keymap.set("n", "<leader>df", "<cmd>Telescope dap frames<cr>", opts)
vim.keymap.set("n", "<leader>dq", "<cmd>Telescope dap configurations<cr>", opts)
vim.keymap.set("n", "<leader>db", "<cmd>Telescope dap list_breakpoints<cr>", opts)
