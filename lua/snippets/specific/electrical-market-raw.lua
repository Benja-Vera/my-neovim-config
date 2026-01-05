local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node

local in_mathzone = function()
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

return {
  -- aa -> \alpha_{n, t}
  s({ trig = 'aa', snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\alpha_{n, t}',
  }),

  -- cc -> c_{n, t}
  s({ trig = 'cc', snippetType = 'autosnippet', condition = in_mathzone }, {
    t 'c_{n, t}',
  }),

  -- zz -> z_{n, t}
  s({ trig = 'zz', snippetType = 'autosnippet', condition = in_mathzone }, {
    t 'z_{n, t}',
  }),

  -- qq -> q_{n, t}
  s({ trig = 'qq', snippetType = 'autosnippet', condition = in_mathzone }, {
    t 'q_{n, t}',
  }),

  -- ff -> f_e
  s({ trig = 'ff', snippetType = 'autosnippet', condition = in_mathzone }, {
    t 'f_e',
  }),

  -- dd -> d_n
  s({ trig = 'dd', snippetType = 'autosnippet', condition = in_mathzone }, {
    t 'd_n',
  }),

  -- rr -> r_e
  s({ trig = 'rr', snippetType = 'autosnippet', condition = in_mathzone }, {
    t 'r_e',
  }),

  -- sgn -> \sgn(n, e)
  s({ trig = 'sgn', snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\sgn(n, e)',
  }),

  -- mm -> \mu_{n, t}
  s({ trig = 'mm', snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\mu_{n, t}',
  }),

  -- ll -> \Lambda_t
  s({ trig = 'll', snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\Lambda_t',
  }),

  -- pp -> \lambda_n
  s({ trig = 'pp', snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\lambda_n',
  }),

  -- xx -> x_{n, t}
  s({ trig = 'xx', snippetType = 'autosnippet', condition = in_mathzone }, {
    t 'x_{n, t}',
  }),

  -- sumnt -> \sum_{n, t}
  s({ trig = 'sumnt', snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\sum_{n, t}',
  }),

  -- sumt -> \sum_t
  s({ trig = 'sumt', snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\sum_t',
  }),

  -- sume -> \sum_{e \\in K_n}
  s({ trig = 'sume', snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\sum_{e \\in K_n}',
  }),

  -- NTCU -> \text{NT}^\text{CU}(\mathbf{q})
  s({ trig = 'NTCU', condition = in_mathzone }, {
    t '\\text{NT}^\\text{CU}(\\mathbf{q})',
  }),

  -- NTCL -> \text{NT}^\text{CL}(\mathbf{q})
  s({ trig = 'NTCL', condition = in_mathzone }, {
    t '\\text{NT}^\\text{CL}(\\mathbf{q})',
  }),
}
