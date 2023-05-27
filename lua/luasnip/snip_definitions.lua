local ls = require'luasnip'
local s, i, t = ls.s, ls.insert_node, ls.text_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep
local c = ls.choice_node
local f = ls.function_node
local sn = ls.sn
local d = ls.dynamic_node

local same = function(index)
  return f(function(arg)
    return arg[1]
  end, { index })
end

ls.add_snippets("all", {
    ls.parser.parse_snippet("exp", "-- this is what got expanded"),
    ls.parser.parse_snippet("lf", "local $1 = function($2)\n  $0\nend"),
    s("sametest", fmt([[example: {}, function: {}]], { i(1), same(1) }))
}, {
    key = "all",
})

ls.add_snippets("dosbatch", {
    s("_echo", fmt([[echo {} = %{}%]], {i(1), same(1)}))
}, {
    key = "dosbatch"
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
  s(">", fmt(">\n\t{}\n\n", { i(0) })),
  s("[", fmt("[\n\t{}\n\n", { i(0) })),
  s("{", fmt("{{\n\t{}\n\n", { i(0) })),
}, {
  key = "typescript",
})

ls.add_snippets("text", {
  ls.parser.parse_snippet("_newday",[[
$1 $2/$3 2023
&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
Idag:
* $0

]])
})
ls.add_snippets("html", {
  s(">", fmt(">\n\t{}\n\n", { i(0) })),
})

ls.add_snippets("xml", {
  s(">", fmt(">\n\t{}\n\n", { i(0) })),
})

ls.add_snippets("cs", {
  s("{", fmt("{{\n\t{}\n\n", { i(0) })),
  s("[", fmt("[\n\t{}\n\n", { i(0) })),
})

ls.add_snippets("java", {
  s("{", fmt("{{\n\t{}\n\n", { i(0) })),
  s("[", fmt("[\n\t{}\n\n", { i(0) })),
  s("smeth", fmt([[
  {} static {} {}({}) {{
      {}
  }}
  ]], { 
    c(1, { t "public", t "private" }),
    i(2, "void"),
    i(3, "name"),
    i(4, "args"),
    i(0),
  }))
})

ls.add_snippets("python", {
  s("_pension_entry", fmt([[self.{} = config_dict["{}"{}]], { i(1), rep(1), t("]") })),
})
