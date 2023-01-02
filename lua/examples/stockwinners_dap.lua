require('dap').configurations.python = {{
    type = "python",
    request = "launch",
    name = "Launch stock-winners",
    program = "${workspaceFolder}/stock_winners/cli.py",
    args = { "stock-winners", "--port", "2000" },
}}

