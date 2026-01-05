local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node

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

  s({
    trig = '\\leftc',
    snippetType = 'autosnippet',
    condition = in_mathzone,
    show_condition = in_mathzone,
    wordTrig = false,
  }, {
    t '\\left\\{',
    i(1),
    t '\\right\\}',
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
}

return M
