local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

local in_mathzone = function()
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

return {
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
}
