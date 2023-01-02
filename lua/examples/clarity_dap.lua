vim.keymap.set("n", "<F5>", ":let $CURRENT_PY_PATH=substitute(expand('%:r'), '/', '.', 'g')<CR> :lua require'dap'.continue()<cr>", opts)
require('dap').configurations.python = {{
    type = "python",
    request = "launch",
    name = "Launch clarity",
    program = "${workspaceFolder}/clarity-ext/clarity_ext/cli.py",
    args = { "--level", "INFO", "extension", "--cache", "False", "${env:CURRENT_PY_PATH}", "test" },
}}

