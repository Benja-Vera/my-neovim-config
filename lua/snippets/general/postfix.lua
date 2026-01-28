local ls = require 'luasnip'
local f = ls.function_node
local t = ls.text_node
local i = ls.insert_node

local postfix = require('luasnip.extras.postfix').postfix

-- Math context check using vimtex
local in_mathzone = function()
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

return {
  -- \alphabar -> \overline{\alpha}
  postfix({ trig = 'bar', match_pattern = [[[\\%w%.%_%-%"%']+$]], condition = in_mathzone, snippetType = 'autosnippet', dscr = 'postfix bar' }, {
    f(function(_, parent)
      return '\\overline{' .. parent.snippet.env.POSTFIX_MATCH .. '}'
    end, {}),
  }),

  -- \alphabf -> \boldsymbol{\alpha}
  postfix({ trig = 'bf', match_pattern = [[[\\%w%.%_%-%"%']+$]], condition = in_mathzone, snippetType = 'autosnippet', dscr = 'postfix bold' }, {
    f(function(_, parent)
      return '\\boldsymbol{' .. parent.snippet.env.POSTFIX_MATCH .. '}'
    end, {}),
  }),

  -- \alphahat -> \hat{\alpha}
  postfix({ trig = 'hat', match_pattern = [[[\\%w%.%_%-%"%']+$]], condition = in_mathzone, snippetType = 'autosnippet', dscr = 'postfix hat' }, {
    f(function(_, parent)
      return '\\hat{' .. parent.snippet.env.POSTFIX_MATCH .. '}'
    end, {}),
  }),

  -- \alphavec -> \vec{\alpha}
  postfix({ trig = 'vec', match_pattern = [[[\\%w%.%_%-%"%']+$]], condition = in_mathzone, snippetType = 'autosnippet', dscr = 'postfix vector' }, {
    f(function(_, parent)
      return '\\vec{' .. parent.snippet.env.POSTFIX_MATCH .. '}'
    end, {}),
  }),

  -- \alphatil -> \tilde{\alpha}
  postfix({ trig = 'til', match_pattern = [[[\\%w%.%_%-%"%']+$]], condition = in_mathzone, snippetType = 'autosnippet', dscr = 'postfix tilde' }, {
    f(function(_, parent)
      return '\\tilde{' .. parent.snippet.env.POSTFIX_MATCH .. '}'
    end, {}),
  }),

  -- Underbrace: (something)./ -> \underbrace{something}_{|}
  postfix({ trig = '._', match_pattern = '%b()', snippetType = 'autosnippet', condition = in_mathzone }, {
    f(function(_, parent)
      return '\\underbrace{' .. parent.snippet.env.POSTFIX_MATCH:sub(2, -2) .. '}_{'
    end, {}),
    i(1, 'annotation'),
    t '}',
  }),
}
