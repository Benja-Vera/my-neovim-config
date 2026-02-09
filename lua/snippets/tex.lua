local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

-- Math context check using vimtex
local in_mathzone = function()
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

M = {
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
    t { '', '\\]', '' },
  }),
}

return M
