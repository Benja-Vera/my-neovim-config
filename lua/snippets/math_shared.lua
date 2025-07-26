local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

local M = {}

M.inline_math = {
  snippet = s({ trig = 'mk', wordTrig = true, snippetType = 'autosnippet' }, {
    t '\\(',
    i(1),
    t '\\)',
  }),
  filetype = { 'tex', 'markdown' },
}

-- display math
M.display_math = {
  snippet = s({ trig = 'dm', wordTrig = false, snippetType = 'autosnippet' }, {
    t { '\\[', '\t' },
    i(1),
    t { '', '\\]' },
  }),
  filetype = { 'tex', 'markwdown' },
}
-- General-purpose sum
M.sum = {
  snippet = s('sum', {
    t '\\sum_{',
    i(1, { 'i=1' }), -- index
    t '}^{',
    i(2, { 'n' }), -- upper limit
    t '} ',
    i(3), -- summand/body
  }),
  filetype = {},
}

-- Finite sums
M.sumiN = {
  snippet = s('sumiN', { t '\\sum_{i=1}^N ', i(0) }),
  filetype = {},
}
M.sumjN = {
  snippet = s('sumjN', { t '\\sum_{j=1}^N ', i(0) }),
  filetype = {},
}
M.sumkN = {
  snippet = s('sumkN', { t '\\sum_{k=1}^N ', i(0) }),
  filetype = {},
}
M.sumnN = {
  snippet = s('sumnN', { t '\\sum_{n=1}^N ', i(0) }),
  filetype = {},
}
M.summN = {
  snippet = s('summN', { t '\\sum_{m=1}^N ', i(0) }),
  filetype = {},
}
M.sumin = {
  snippet = s('sumin', { t '\\sum_{i=1}^n ', i(0) }),
  filetype = {},
}
M.sumjn = {
  snippet = s('sumjn', { t '\\sum_{j=1}^n ', i(0) }),
  filetype = {},
}
M.sumkn = {
  snippet = s('sumkn', { t '\\sum_{k=1}^n ', i(0) }),
  filetype = {},
}

-- Infinite sums
M.sumi = {
  snippet = s('sumi', { t '\\sum_{i \\in \\mathbb{N}} ', i(0) }),
  filetype = {},
}
M.sumj = {
  snippet = s('sumj', { t '\\sum_{j \\in \\mathbb{N}} ', i(0) }),
  filetype = {},
}
M.sumk = {
  snippet = s('sumk', { t '\\sum_{k \\in \\mathbb{N}} ', i(0) }),
  filetype = {},
}
M.sumn = {
  snippet = s('sumn', { t '\\sum_{n \\in \\mathbb{N}} ', i(0) }),
  filetype = {},
}
M.summ = {
  snippet = s('summ', { t '\\sum_{m \\in \\mathbb{N}} ', i(0) }),
  filetype = {},
}

-- Fractions
M.frac = {
  snippet = s({
    trig = '([%w\\_^{}]+)%/',
    regTrig = true,
    snippetType = 'autosnippet',
  }, {
    f(function(_, snip)
      return '\\frac{' .. snip.captures[1] .. '}{'
    end, {}),
    i(1),
    t '}',
  }),
  filetype = {},
}

-- Fractions: handling parentheses
M.paren_frac = {
  snippet = s({
    trig = 'parfrac', -- dummy trigger, we'll invoke it manually
    snippetType = 'snippet',
  }, {
    f(function(_, snip)
      local line = vim.fn.getline '.'
      local col = vim.fn.col '.' - 1 -- before the slash
      local i = col - 1
      local depth = 0

      -- Walk backwards to find matching opening parenthesis
      while i >= 1 do
        local char = line:sub(i, i)
        if char == ')' then
          depth = depth + 1
        elseif char == '(' then
          depth = depth - 1
          if depth == 0 then
            break
          end
        end
        i = i - 1
      end

      if i < 1 then
        return ''
      end

      local inner = line:sub(i + 1, col - 1)

      return '\\frac{' .. inner .. '}{'
    end, {}),
    i(1),
    t '}',
  }),
  filetype = {},
}

return M
