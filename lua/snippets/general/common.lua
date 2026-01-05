local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

-- Math context check using vimtex
local in_mathzone = function()
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

return {
  -- SET -> \{|\}
  s({ trig = 'SET', snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\{',
    i(0),
    t '\\}',
  }),

  -- custom symbols
  -- "->" -> \mapsto
  -- s({
  --   trig = '->',
  --   wordTrig = true,
  --   snippetType = 'autosnippet',
  --   condition = in_mathzone,
  --   show_condition = in_mathzone,
  -- }, {
  --   t '\\mapsto',
  -- }),

  -- "->>" -> \twoheadrightarrow
  s({
    trig = '->>',
    wordTrig = true,
    snippetType = 'autosnippet',
    condition = in_mathzone,
    show_condition = in_mathzone,
  }, {
    t '\\twoheadrightarrow',
  }),

  -- oo -> \infty
  s({
    trig = 'oo',
    wordTrig = false,
    snippetType = 'autosnippet',
    condition = in_mathzone,
    show_condition = in_mathzone,
  }, {
    t '\\infty',
  }),

  -- c= -> \subseteq
  s({
    trig = 'c=',
    snippetType = 'autosnippet',
    condition = in_mathzone,
    show_condition = in_mathzone,
  }, {
    t '\\subseteq',
  }),

  -- ... -> \dots
  s({
    trig = '...',
    snippetType = 'autosnippet',
    condition = in_mathzone,
    show_condition = in_mathzone,
  }, {
    t '\\dots',
  }),

  -- txt -> \text{|}
  s({
    trig = 'txt',
    snippetType = 'autosnippet',
    condition = in_mathzone,
    show_condition = in_mathzone,
  }, {
    t '\\text{',
    i(1),
    t '}',
    i(0),
  }),

  -- sub -> _{}
  s({
    trig = 'sub',
    wordTrig = false,
    snippetType = 'autosnippet',
    condition = in_mathzone,
    show_condition = in_mathzone,
  }, {
    t '_{',
    i(1),
    t '}',
    filetype = {},
  }),

  -- ee -> e^{|}
  s({ trig = 'ee', snippetType = 'autosnippet', condition = in_mathzone }, {
    t 'e^{',
    i(1),
    t '}',
    i(0),
  }),

  -- dd -> \mathrm{d}
  s({ trig = 'dd', snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\mathrm{d}',
  }),
}
