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

  -- A L P H A B E T
  -- generic mathcal
  s({ trig = 'CAL', wordTrig = true, snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\mathcal{',
    i(1),
    t '}',
    filetype = {},
  }),

  -- A
  s({ trig = 'AA', wordTrig = true, snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\mathcal{A}',
  }),

  -- B
  s({ trig = 'BB', wordTrig = true, snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\mathcal{B}',
  }),

  -- C
  s({ trig = 'CC', wordTrig = true, snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\mathbb{C}',
  }),

  -- D
  s({ trig = 'DD', wordTrig = true, snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\mathcal{D}',
  }),

  -- E
  s({ trig = 'EE', wordTrig = true, snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\mathbb{E}',
  }),

  -- F
  s({ trig = 'FF', wordTrig = true, snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\mathcal{F}',
  }),

  -- G
  s({ trig = 'GG', wordTrig = true, snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\mathcal{G}',
  }),

  -- H
  s({ trig = 'HH', wordTrig = true, snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\mathcal{H}',
  }),

  -- I
  s({ trig = 'II', wordTrig = true, snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\mathcal{I}',
  }),

  -- K
  s({ trig = 'KK', wordTrig = true, snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\mathcal{K}',
  }),

  -- L
  s({ trig = 'LL', wordTrig = true, snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\mathcal{L}',
  }),

  -- M
  s({ trig = 'MM', wordTrig = true, snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\mathcal{M}',
  }),

  -- N
  s({ trig = 'NN', wordTrig = true, snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\mathbb{N}',
  }),

  -- O
  s({ trig = 'OO', wordTrig = true, snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\mathcal{O}',
  }),

  -- P
  s({ trig = 'PP', wordTrig = true, snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\mathcal{P}',
  }),

  -- Q
  s({ trig = 'QQ', wordTrig = true, snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\mathcal{Q}',
  }),

  -- R
  s({ trig = 'RR', wordTrig = true, snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\mathbb{R}',
  }),

  -- S
  s({ trig = 'SS', wordTrig = true, snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\mathcal{S}',
  }),

  -- T
  s({ trig = 'TT', wordTrig = true, snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\mathcal{T}',
  }),

  -- U
  s({ trig = 'UU', wordTrig = true, snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\mathcal{U}',
  }),

  -- W
  s({ trig = 'WW', wordTrig = true, snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\mathcal{W}',
  }),

  -- X
  s({ trig = 'XX', wordTrig = true, snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\mathcal{X}',
  }),

  -- Y
  s({ trig = 'YY', wordTrig = true, snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\mathcal{Y}',
  }),

  -- Z
  s({ trig = 'ZZ', wordTrig = true, snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\mathbb{Z}',
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

local index_pairs = {
  i = { 'n', 'N', 'm', 'M' },
  j = { 'n', 'N', 'm', 'M' },
  k = { 'n', 'N', 'm', 'M' },
  m = { 'n', 'N', 'M' },
  n = { 'm', 'N', 'M' },
}

local operators = {
  sum = '\\sum',
  union = '\\bigcup',
  inter = '\\bigcap',
  dunion = '\\bigsqcup',
}

for op, stx in pairs(operators) do
  for idx, upper_lims in pairs(index_pairs) do
    for _, lim in ipairs(upper_lims) do
      local trig = op .. idx .. lim
      local str = stx .. '_{' .. idx .. '=1}^' .. lim .. ' '
      table.insert(M, s({ trig = trig, condition = in_mathzone }, { t(str), i(0) })) -- finite operator
    end

    local trig_inf = op .. idx
    local inf_str = stx .. '_{' .. idx .. ' \\in \\mathbb{N}} '
    table.insert(M, s({ trig = trig_inf, condition = in_mathzone }, { t(inf_str), i(0) })) -- inifnite operator
  end
  table.insert(
    M,
    -- General-purpose operator
    s({ trig = op, condition = in_mathzone }, {
      t(stx .. '_{'),
      i(1, { 'i=1' }), -- index
      t '}^{',
      i(2, { 'n' }), -- upper limit
      t '} ',
      i(3), -- body
    })
  )
end

return M
