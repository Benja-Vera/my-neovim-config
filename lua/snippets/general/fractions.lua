local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

local postfix = require('luasnip.extras.postfix').postfix

-- Math context check using vimtex
local in_mathzone = function()
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

return {
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

  -- Fractions: (something)./ -> \frac{something}{|}
  postfix({ trig = './', match_pattern = '%b()', snippetType = 'autosnippet', condition = in_mathzone }, {
    f(function(_, parent)
      return '\\frac{' .. parent.snippet.env.POSTFIX_MATCH:sub(2, -2) .. '}{'
    end, {}),
    i(1, 'denominator'),
    t '}',
  }),
}
