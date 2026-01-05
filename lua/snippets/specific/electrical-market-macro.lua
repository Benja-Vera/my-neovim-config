local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

local postfix = require('luasnip.extras.postfix').postfix

local in_mathzone = function()
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

return {
  -- aa -> \bid
  s({ trig = 'aa', snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\bid',
  }),

  -- zz -> \polutionfactor
  s({ trig = 'zz', snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\pollutionfactor',
  }),

  -- qq -> \production
  s({ trig = 'qq', snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\production',
  }),

  -- ff -> \flow
  s({ trig = 'ff', snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\flow',
  }),

  -- dd -> \demand
  s({ trig = 'dd', snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\demand',
  }),

  -- rr -> \resistance
  s({ trig = 'rr', snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\resistance',
  }),

  -- sgn -> \sgn(\node, \edge)
  s({ trig = 'sgn', snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\sgn(\\node, \\edge)',
  }),

  -- mm -> \kktcapacitylower
  s({ trig = 'mm', snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\kktcapacitylower',
  }),

  -- ll -> \pollutioncost
  s({ trig = 'll', snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\pollutioncost',
  }),

  -- pp -> \price
  s({ trig = 'pp', snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\price',
  }),

  -- xx -> x_{n, t}
  s({ trig = 'xx', snippetType = 'autosnippet', condition = in_mathzone }, {
    t 'x_{n, t}',
  }),

  -- sumnt -> \sum_{\node, \tech}
  s({ trig = 'sumnt', snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\sum_{\\node, \\tech}',
  }),

  -- sumt -> \sum_{\tech}
  s({ trig = 'sumt', snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\sum_{\\tech}',
  }),

  -- sume -> \sum_{\edge \in \neighbourset}
  s({ trig = 'sume', snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\sum_{\\edge \\in \\neighbourset}',
  }),

  -- NTCU -> \text{NT}^\text{CU}(\boldsymbol{q})
  s({ trig = 'NTCU', condition = in_mathzone }, {
    t '\\text{NT}^\\text{CU}(\\boldsymbol{q})',
  }),

  -- NTCL -> \text{NT}^\text{CL}(\boldsymbol{q})
  s({ trig = 'NTCL', condition = in_mathzone }, {
    t '\\text{NT}^\\text{CL}(\\boldsymbol{q})',
  }),

  postfix({
    trig = '.p',
    match_pattern = '\\(bid|production)$',
    snippetType = 'autosnippet',
    condition = in_mathzone,
  }, {
    f(function(_, parent)
      return parent.snippet.env.POSTFIX_MATCH
    end),
    t '[',
    i(1, 'n'),
    t '][',
    i(2, 't'),
    t ']',
  }),
}
