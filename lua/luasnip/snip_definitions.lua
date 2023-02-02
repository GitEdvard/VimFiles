local ls = require'luasnip'

ls.add_snippets("all", {
    ls.parser.parse_snippet("exp", "-- this is what got expanded"),
    ls.parser.parse_snippet("lf", "local $1 = function($2)\n  $0\nend"),
}, {
    key = "all",
})
ls.add_snippets("vim", {
  ls.parser.parse_snippet("_caption",[[
"-------------------------------------------------------------
" $1
]]),
  ls.parser.parse_snippet("_plugevent", [[
augroup $1
    autocmd!
    autocmd User plug-event $2
augroup END
]]),
}, {
  key = "vim",
})
ls.add_snippets("typescript", {
  ls.parser.parse_snippet("import", "import { $1 } from '$2'"),
  ls.parser.parse_snippet("butt", "<button class=\"btn btn-primary\" (click) = \"$1\">$2</button>"),
}, {
  key = "typescript",
})

