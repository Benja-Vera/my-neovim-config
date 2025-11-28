local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local sn = ls.snippet_node
local fmt = require('luasnip.extras.fmt').fmt
local rep = require('luasnip.extras').rep

-- Math context check using vimtex
local in_mathzone = function()
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

M = {
  -- BLOCKS
  -- definition
  s(
    'def',
    fmt(
      [[
    ::: {{#def-{}}}
    {}
    {}
    :::
  ]],
      {
        i(1, 'label'),
        c(2, {
          fmt('## {}\n', i(1, 'name')), -- Option: name line
          t '', -- Option: no name line
        }),
        i(3, 'body'),
      }
    )
  ),
  -- problem + solution
  s(
    'exr',
    fmt(
      [[
    ::: {{#exr-{}}}
    {}
    {}
    :::

    ::: {{.callout collapse=true}}
    ## Solución
    {}
    :::
    ]],
      {
        i(1, 'label'), -- label only for the exercise
        c(2, {
          fmt('## {}\n', i(1, 'Exercise Title')), -- optional title
          t '', -- no title
        }),
        i(3, 'Problem body'),
        i(4, 'Solution body'),
      }
    )
  ),
  -- solution
  s({
    trig = 'solucion',
  }, {
    t {
      '::: {.callout collapse=true}',
      '## Solución',
      '',
    },
    i(0),
    t {
      '',
      ':::',
    },
  }),
  -- Hoja de ruta
  s({
    trig = 'hoja-de-ruta',
  }, {
    t {
      '::: {.callout-tip}',
      '## Hoja de ruta',
      '',
    },
    i(0),
    t {
      '',
      ':::',
    },
  }),
  -- Conclusión
  s({
    trig = 'conclusión',
  }, {
    t {
      '::: {.callout-tip icon=false}',
      '## Conclusión',
      '',
    },
    i(0),
    t {
      '',
      ':::',
    },
  }),

  -- DIFFERENTIAL OPERATORS
  -- Derivative: d f / d x
  s({
    trig = 'DV',
    snippetType = 'autosnippet',
    condition = in_mathzone,
    show_condition = in_mathzone,
  }, {
    t '\\frac{\\mathrm{d} ',
    i(1, 'f'),
    t '}{\\mathrm{d} ',
    i(2, 'x'),
    t '}',
  }),

  -- Partial derivative: ∂ f / ∂ x
  s({
    trig = 'PDV',
    snippetType = 'autosnippet',
    condition = in_mathzone,
    show_condition = in_mathzone,
  }, {
    t '\\frac{\\partial ',
    i(1, 'f'),
    t '}{\\partial ',
    i(2, 'x'),
    t '}',
  }),

  -- Higher order derivative: d^n f / d x^n
  s({
    trig = 'DVN',
    snippetType = 'autosnippet',
    condition = in_mathzone,
    show_condition = in_mathzone,
  }, {
    t '\\frac{\\mathrm{d}^{',
    i(1, 'n'),
    t '} ',
    i(2, 'f'),
    t '}{\\mathrm{d} ',
    i(3, 'x'),
    t '^{',
    rep(1),
    t '}}',
  }),

  -- Higher order partial derivative: ∂^n f / ∂ x^n
  s({
    trig = 'PDVN',
    snippetType = 'autosnippet',
    condition = in_mathzone,
    show_condition = in_mathzone,
  }, {
    t '\\frac{\\partial^{',
    i(1, 'n'),
    t '} ',
    i(2, 'f'),
    t '}{\\partial ',
    i(3, 'x'),
    t '^{',
    rep(1),
    t '}}',
  }),

  -- ENVIRONMENTS
  -- bracket matrix
  s({
    trig = 'BMAT',
    snippetType = 'autosnippet',
    condition = in_mathzone,
    show_condition = in_mathzone,
  }, {
    t { '\\begin{bmatrix}', '' },
    i(1),
    t { '', '\\end{bmatrix}' },
  }),

  -- parentheses matrix
  s({
    trig = 'PMAT',
    snippetType = 'autosnippet',
    condition = in_mathzone,
    show_condition = in_mathzone,
  }, {
    t { '\\begin{pmatrix}', '' },
    i(1),
    t { '', '\\end{pmatrix}' },
  }),

  -- determinant matrix
  s({
    trig = 'VMAT',
    snippetType = 'autosnippet',
    condition = in_mathzone,
    show_condition = in_mathzone,
  }, {
    t { '\\begin{vmatrix}', '' },
    i(1),
    t { '', '\\end{vmatrix}' },
  }),

  -- numbered align
  s({
    trig = 'BAL',
    snippetType = 'autosnippet',
    condition = in_mathzone,
    show_condition = in_mathzone,
  }, {
    t { '\\begin{align}', '' },
    i(1),
    t { '', '\\end{align}' },
  }),

  -- unnumbered align
  s({
    trig = 'BSAL',
    snippetType = 'autosnippet',
    condition = in_mathzone,
    show_condition = in_mathzone,
  }, {
    t { '\\begin{align*}', '' },
    i(1),
    t { '', '\\end{align*}' },
  }),

  -- numbered equation
  s({
    trig = 'BEQ',
    snippetType = 'autosnippet',
    condition = in_mathzone,
    show_condition = in_mathzone,
  }, {
    t { '\\begin{equation}', '' },
    i(1),
    t { '', '\\end{equation}' },
  }),

  -- cases
  s({
    trig = 'BCAS',
    snippetType = 'autosnippet',
    condition = in_mathzone,
    show_condition = in_mathzone,
  }, {
    t { '\\begin{cases}', '' },
    i(1),
    t { '', '\\end{cases}' },
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

  -- cc -> \subseteq
  s({
    trig = 'cc',
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

  -- SET -> \{ ... \}
  s({
    trig = 'SET',
    snippetType = 'autosnippet',
    condition = in_mathzone,
    show_condition = in_mathzone,
  }, {
    t '\\{',
    i(1),
    t '\\}',
    i(0),
  }),

  -- GEN -> \langle #1 \rangle #2
  s({
    trig = 'GEN',
    snippetType = 'autosnippet',
    condition = in_mathzone,
    show_condition = in_mathzone,
  }, {
    t '\\langle ',
    i(1),
    t ' \\rangle ',
    i(0),
  }),

  -- LEFT RIGHT EXPRESSIONS
  s({
    trig = '\\leftp',
    snippetType = 'autosnippet',
    condition = in_mathzone,
    show_condition = in_mathzone,
    wordTrig = false,
  }, {
    t '\\left(',
    i(1),
    t '\\right)',
  }),

  s({
    trig = '\\leftb',
    snippetType = 'autosnippet',
    condition = in_mathzone,
    show_condition = in_mathzone,
    wordTrig = false,
  }, {
    t '\\left[',
    i(1),
    t '\\right]',
  }),

  s({
    trig = '\\leftv',
    snippetType = 'autosnippet',
    condition = in_mathzone,
    show_condition = in_mathzone,
    wordTrig = false,
  }, {
    t '\\left|',
    i(1),
    t '\\right|',
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
  s({
    trig = 'CAL',
    wordTrig = true,
    snippetType = 'autosnippet',
    condition = in_mathzone,
    show_condition = in_mathzone,
  }, {
    t '\\mathcal{',
    i(1),
    t '}',
    filetype = {},
  }),

  -- A
  s({
    trig = 'AA',
    wordTrig = true,
    snippetType = 'autosnippet',
    condition = in_mathzone,
    show_condition = in_mathzone,
  }, {
    t '\\mathcal{A}',
  }),

  -- B
  s({
    trig = 'BB',
    wordTrig = true,
    snippetType = 'autosnippet',
    condition = in_mathzone,
    show_condition = in_mathzone,
  }, {
    t '\\mathcal{B}',
  }),

  -- C
  s({
    trig = 'CC',
    wordTrig = true,
    snippetType = 'autosnippet',
    condition = in_mathzone,
    show_condition = in_mathzone,
  }, {
    t '\\mathbb{C}',
  }),

  -- D
  s({
    trig = 'DD',
    wordTrig = true,
    snippetType = 'autosnippet',
    condition = in_mathzone,
    show_condition = in_mathzone,
  }, {
    t '\\mathcal{D}',
  }),

  -- E
  s({
    trig = 'EE',
    wordTrig = true,
    snippetType = 'autosnippet',
    condition = in_mathzone,
    show_condition = in_mathzone,
  }, {
    t '\\mathbb{E}',
  }),

  -- F
  s({
    trig = 'FF',
    wordTrig = true,
    snippetType = 'autosnippet',
    condition = in_mathzone,
    show_condition = in_mathzone,
  }, {
    t '\\mathcal{F}',
  }),

  -- G
  s({
    trig = 'GG',
    wordTrig = true,
    snippetType = 'autosnippet',
    condition = in_mathzone,
    show_condition = in_mathzone,
  }, {
    t '\\mathcal{G}',
  }),

  -- H
  s({
    trig = 'HH',
    wordTrig = true,
    snippetType = 'autosnippet',
    condition = in_mathzone,
    show_condition = in_mathzone,
  }, {
    t '\\mathcal{H}',
  }),

  -- I
  s({
    trig = 'II',
    wordTrig = true,
    snippetType = 'autosnippet',
    condition = in_mathzone,
    show_condition = in_mathzone,
  }, {
    t '\\mathcal{I}',
  }),

  -- K
  s({
    trig = 'KK',
    wordTrig = true,
    snippetType = 'autosnippet',
    condition = in_mathzone,
    show_condition = in_mathzone,
  }, {
    t '\\mathbb{K}',
  }),

  -- L
  s({
    trig = 'LL',
    wordTrig = true,
    snippetType = 'autosnippet',
    condition = in_mathzone,
    show_condition = in_mathzone,
  }, {
    t '\\mathcal{L}',
  }),

  -- M
  s({
    trig = 'MM',
    wordTrig = true,
    snippetType = 'autosnippet',
    condition = in_mathzone,
    show_condition = in_mathzone,
  }, {
    t '\\mathcal{M}',
  }),

  -- N
  s({
    trig = 'NN',
    wordTrig = true,
    snippetType = 'autosnippet',
    condition = in_mathzone,
    show_condition = in_mathzone,
  }, {
    t '\\mathbb{N}',
  }),

  -- O
  s({
    trig = 'OO',
    wordTrig = true,
    snippetType = 'autosnippet',
    condition = in_mathzone,
    show_condition = in_mathzone,
  }, {
    t '\\mathcal{O}',
  }),

  -- P
  s({
    trig = 'PP',
    wordTrig = true,
    snippetType = 'autosnippet',
    condition = in_mathzone,
    show_condition = in_mathzone,
  }, {
    t '\\mathbb{P}',
  }),

  -- Q
  s({
    trig = 'QQ',
    wordTrig = true,
    snippetType = 'autosnippet',
    condition = in_mathzone,
    show_condition = in_mathzone,
  }, {
    t '\\mathcal{Q}',
  }),

  -- R
  s({
    trig = 'RR',
    wordTrig = true,
    snippetType = 'autosnippet',
    condition = in_mathzone,
    show_condition = in_mathzone,
  }, {
    t '\\mathbb{R}',
  }),

  -- S
  s({
    trig = 'SS',
    wordTrig = true,
    snippetType = 'autosnippet',
    condition = in_mathzone,
    show_condition = in_mathzone,
  }, {
    t '\\mathcal{S}',
  }),

  -- T
  s({
    trig = 'TT',
    wordTrig = true,
    snippetType = 'autosnippet',
    condition = in_mathzone,
    show_condition = in_mathzone,
  }, {
    t '\\mathcal{T}',
  }),

  -- U
  s({
    trig = 'UU',
    wordTrig = true,
    snippetType = 'autosnippet',
    condition = in_mathzone,
    show_condition = in_mathzone,
  }, {
    t '\\mathcal{U}',
  }),

  -- W
  s({
    trig = 'WW',
    wordTrig = true,
    snippetType = 'autosnippet',
    condition = in_mathzone,
    show_condition = in_mathzone,
  }, {
    t '\\mathcal{W}',
  }),

  -- X
  s({
    trig = 'XX',
    wordTrig = true,
    snippetType = 'autosnippet',
    condition = in_mathzone,
    show_condition = in_mathzone,
  }, {
    t '\\mathcal{X}',
  }),

  -- Y
  s({
    trig = 'YY',
    wordTrig = true,
    snippetType = 'autosnippet',
    condition = in_mathzone,
    show_condition = in_mathzone,
  }, {
    t '\\mathcal{Y}',
  }),

  -- Z
  s({
    trig = 'ZZ',
    wordTrig = true,
    snippetType = 'autosnippet',
    condition = in_mathzone,
    show_condition = in_mathzone,
  }, {
    t '\\mathbb{Z}',
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

  -- MATH ENVIRONMENTS
  -- inline math
  s({ trig = 'mk', wordTrig = true, snippetType = 'autosnippet' }, {
    t '$',
    i(1),
    t '$',
  }),

  -- display math
  s({ trig = 'dm', wordTrig = true, snippetType = 'autosnippet' }, {
    t { '$$', '\t' },
    i(1),
    t { '', '$$' },
  }),

  -- Fractions: // -> \frac{|}{}
  s({
    trig = '//',
    name = 'Fraction',
    dscr = 'Expands to \\frac{}{} (only in math mode)',
    snippetType = 'autosnippet',
    wordTrig = false,
    condition = in_mathzone, -- ← only expands in math environments
    show_condition = in_mathzone,
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
    show_condition = in_mathzone,
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
      table.insert(M, s({ trig = trig, condition = in_mathzone, show_condition = in_mathzone }, { t(str), i(0) })) -- finite operator
    end

    local trig_inf = op .. idx
    local inf_str = stx .. '_{' .. idx .. ' \\in \\mathbb{N}} '
    table.insert(M, s({ trig = trig_inf, condition = in_mathzone, show_condition = in_mathzone }, { t(inf_str), i(0) })) -- inifnite operator
  end
  table.insert(
    M,
    -- General-purpose operator
    s({ trig = op, condition = in_mathzone, show_condition = in_mathzone }, {
      t(stx .. '_{'),
      i(1, 'i=1'),
      t '}',
      c(2, {
        -- With upper limit
        sn(nil, { t '^{', i(1, 'n'), t '}' }),
        -- No upper limit
        t '',
      }),
      t ' ',
      i(3), -- main expression
    })
  )
end

return M
