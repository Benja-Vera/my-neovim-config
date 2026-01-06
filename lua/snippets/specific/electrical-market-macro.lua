local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

local in_mathzone = function()
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

return {
  -- tt -> \tax
  s({ trig = 'tt', snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\tax',
  }),

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

  -- cc -> \isocost
  s({ trig = 'cc', snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\isocost',
  }),

  -- mm -> \kktcapacitylower
  s({ trig = 'mm', snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\kktcapacitylower',
  }),

  -- mM -> \kktcapacityupper
  s({ trig = 'mM', snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\kktcapacityupper',
  }),

  -- dd -> \demand
  s({ trig = 'dd', snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\demand',
  }),

  -- pp -> \price
  s({ trig = 'pp', snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\price',
  }),

  -- rr -> \resistance
  s({ trig = 'rr', snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\resistance',
  }),

  -- ff -> \flow
  s({ trig = 'ff', snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\flow',
  }),

  -- sgn -> \sgn(\node, \edge)
  s({ trig = 'sgn', snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\sgn(\\node, \\edge)',
  }),

  -- ll -> \pollutioncost
  s({ trig = 'll', snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\pollutioncost',
  }),

  -- xx -> x_{\node, \tech}
  s({ trig = 'xx', snippetType = 'autosnippet', condition = in_mathzone }, {
    t '\\deviation',
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

  -- \bid.p -> \bid[\node_0][\tech_0] (postfix)
  s({
    trig = '(\\\\bid|\\\\production|\\\\pollutionfactor|\\\\kktcapacitylower|\\\\kktcapacityupper|\\\\isocost|\\\\deviation).p',
    regTrig = true,
    trigEngine = 'ecma',
    snippetType = 'autosnippet',
    condition = in_mathzone,
    desc = 'add parameters',
  }, {
    f(function(_, snip)
      return snip.captures[1] .. '['
    end),
    i(1, '\\node_0'),
    t '][',
    i(2, '\\tech_0'),
    t '] ',
  }),

  -- \demand.p -> \demand[\node_0] (postfix)
  s({
    trig = '(\\\\demand|\\\\price).p',
    regTrig = true,
    trigEngine = 'ecma',
    snippetType = 'autosnippet',
    condition = in_mathzone,
    desc = 'add parameters',
  }, {
    f(function(_, snip)
      return snip.captures[1] .. '['
    end),
    i(1, '\\node_0'),
    t ']',
  }),

  -- \resistance.p -> \resistance[\edge_0] (postfix)
  s({
    trig = '(\\\\resistance|\\\\flow).p',
    regTrig = true,
    trigEngine = 'ecma',
    snippetType = 'autosnippet',
    condition = in_mathzone,
    desc = 'add parameters',
  }, {
    f(function(_, snip)
      return snip.captures[1] .. '['
    end),
    i(1, '\\edge_0'),
    t ']',
  }),

  -- \pollutioncost.p -> \pollutioncost[\tech_0] (postfix)
  s({
    trig = '\\pollutioncost.p',
    snippetType = 'autosnippet',
    condition = in_mathzone,
    desc = 'add parameters',
  }, {
    t '\\pollutioncost[',
    i(1, '\\tech_0'),
    t ']',
  }),
}
