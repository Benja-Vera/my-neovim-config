-- plugins/quarto.lua
return {
  {
    'quarto-dev/quarto-nvim',
    dependencies = {
      'jmbuhr/otter.nvim',
      { 'quarto-dev/quarto-vim', ft = 'quarto', dependencies = { 'vim-pandoc/vim-pandoc-syntax' } },
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('quarto').setup {
        lspFeatures = {
          languages = { 'python', 'julia' },
        },
      }

      -- Only load when editing quarto files
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'quarto',
        callback = function()
          require 'mappings.quarto-math-mappings'()
        end,
      })

      -- build a path relative to your nvim config
      local snippet_path = vim.fn.stdpath 'config' .. '/lua/snippets/electrical-market.lua'

      vim.keymap.set('n', '<leader>qsm', function()
        local ls = require 'luasnip'
        local s = ls.snippet
        local t = ls.text_node

        -- Math context check using vimtex
        local in_mathzone = function()
          return vim.fn['vimtex#syntax#in_mathzone']() == 1
        end

        ls.add_snippets('quarto', {
          -- aa -> \alpha_{n, t}
          s({ trig = 'aa', snippetType = 'autosnippet', condition = in_mathzone }, {
            t '\\alpha_{n, t}',
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
        })
        print 'Electrical market snippets loaded sucessfully'
      end, { desc = 'Load electrical market snippets' })
    end,
  },
}
