require("luasnip.loaders.from_vscode").lazy_load()
-- Copied from tj devries video
local ls = require'luasnip'
local types = require'luasnip.util.types'

ls.config.set_config {
  history = true,
  updateevents = "TextChanged", "TextChangedI",
  enable_autosnippets = true,
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { "<--", "Error" } },
      },
    },
  },
}

vim.keymap.set({ 'i', 's' }, '<c-k>', function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end)

vim.keymap.set({ 'i', 's' }, '<c-j>', function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })

vim.keymap.set({ 'i', 's' }, '<c-l>', function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, { silent = true })

vim.keymap.set('n', '<leader><leader>s', '<cmd>source ~/.vim/plugged/LuaSnip/plugin/luasnip.vim<cr>')

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
}, {
  key = "typescript",
})
