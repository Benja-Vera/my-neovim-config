local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

-- Math context check using vimtex
local in_mathzone = function()
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

M = {
  -- custom symbols
  -- "->" -> \to
  s({ trig = '->', wordTrig = true, snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\to',
  }),

  -- oo -> \infty
  s({ trig = 'oo', wordTrig = false, snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\infty',
  }),

  -- cc -> \subseteq
  s({ trig = 'cc', snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\subseteq',
  }),

  -- SET -> \{|\}
  s({ trig = 'SET', snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\{',
    i(0),
    t '\\}',
  }),

  -- High-priority: ([a-zA-Z])bar -> \overline{<letter>}
  s({
    trig = '([a-zA-Z])bar',
    regTrig = true,
    snippetType = 'autosnippet',
    priority = 100,
    condition = in_mathzone,
    show_condition = in_mathzone,
  }, {
    f(function(_, snip)
      return '\\overline{' .. snip.captures[1] .. '}'
    end, {}),
  }),

  -- Lower-priority: bar -> \overline{<cursor>}
  s({
    trig = 'bar',
    snippetType = 'autosnippet',
    priority = 10,
    condition = in_mathzone,
    show_condition = in_mathzone,
  }, {
    t '\\overline{',
    i(1),
    t '}',
    i(0),
  }),

  -- same with \hat{}
  s({
    trig = '([a-zA-Z])hat',
    regTrig = true,
    snippetType = 'autosnippet',
    priority = 100,
    condition = in_mathzone,
    show_condition = in_mathzone,
  }, {
    f(function(_, snip)
      return '\\hat{' .. snip.captures[1] .. '}'
    end, {}),
  }),

  s({
    trig = 'hat',
    snippetType = 'autosnippet',
    priority = 10,
    condition = in_mathzone,
    show_condition = in_mathzone,
  }, {
    t '\\hat{',
    i(1),
    t '}',
    i(0),
  }),

  -- same with \mathbf{}
  s({
    trig = '([a-zA-Z])bf',
    regTrig = true,
    snippetType = 'autosnippet',
    priority = 100,
    condition = in_mathzone,
    show_condition = in_mathzone,
  }, {
    f(function(_, snip)
      return '\\mathbf{' .. snip.captures[1] .. '}'
    end, {}),
  }),

  s({
    trig = 'bf',
    snippetType = 'autosnippet',
    priority = 10,
    condition = in_mathzone,
    show_condition = in_mathzone,
  }, {
    t '\\mathbf{',
    i(1),
    t '}',
    i(0),
  }),

  -- same with \tilde{}
  s({
    trig = '([a-zA-Z])til',
    regTrig = true,
    snippetType = 'autosnippet',
    priority = 100,
    condition = in_mathzone,
    show_condition = in_mathzone,
  }, {
    f(function(_, snip)
      return '\\tilde{' .. snip.captures[1] .. '}'
    end, {}),
  }),

  s({
    trig = 'til',
    snippetType = 'autosnippet',
    priority = 10,
    condition = in_mathzone,
    show_condition = in_mathzone,
  }, {
    t '\\tilde{',
    i(1),
    t '}',
    i(0),
  }),

  -- same with \text{}
  s({
    trig = '([a-zA-Z])txt',
    regTrig = true,
    snippetType = 'autosnippet',
    priority = 100,
    condition = in_mathzone,
    show_condition = in_mathzone,
  }, {
    f(function(_, snip)
      return '\\text{' .. snip.captures[1] .. '}'
    end, {}),
  }),

  s({
    trig = 'txt',
    snippetType = 'autosnippet',
    priority = 10,
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

  -- MATH ENVIRONMENTS
  -- inline math
  s({ trig = 'mk', wordTrig = true, snippetType = 'autosnippet' }, {
    t '\\(',
    i(1),
    t '\\)',
  }),

  -- display math
  s({ trig = 'dm', wordTrig = true, snippetType = 'autosnippet' }, {
    t { '\\[', '\t' },
    i(1),
    t { '', '\\]' },
  }),

  -- Fractions: // -> \frac{|}{}
  s({
    trig = '//',
    name = 'Fraction',
    dscr = 'Expands to \\frac{}{} (only in math mode)',
    snippetType = 'autosnippet',
    wordTrig = false,
    condition = in_mathzone, -- ← only expands in math environments
    priority = 1000,
  }, {
    t '\\frac{',
    i(1),
    t '}{',
    i(2),
    t '}',
    i(0),
  }),

  -- Fractions: 3/ -> \frac{3}{|}
  s({
    trig = '([%w\\_^{}]+)%/',
    regTrig = true,
    snippetType = 'autosnippet',
    condition = in_mathzone,
  }, {
    f(function(_, snip)
      return '\\frac{' .. snip.captures[1] .. '}{'
    end, {}),
    i(1),
    t '}',
  }),
}

return M
