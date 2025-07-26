-- autopairs
-- https://github.com/windwp/nvim-autopairs

return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  config = function()
    local npairs = require 'nvim-autopairs'
    local Rule = require 'nvim-autopairs.rule'

    npairs.setup {}

    -- Add custom rule: $$...$$ in tex files
    npairs.add_rule(Rule('$$', '$$', 'tex'):with_move(function(opts)
      return opts.prev_char:match '.$' ~= nil
    end):with_pair(function(opts)
      -- Avoid adding pair if already closed
      local next_char = opts.line:sub(opts.col, opts.col)
      return next_char ~= '$'
    end))

    -- Optional: also add the same rule for markdown and quarto files
    npairs.add_rule(Rule('$$', '$$', 'markdown'))
    npairs.add_rule(Rule('$$', '$$', 'quarto'))
  end,
}
