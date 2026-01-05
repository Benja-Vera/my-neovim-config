local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node

local sn = ls.snippet_node

-- Math context check using vimtex
local in_mathzone = function()
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

M = {}

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
