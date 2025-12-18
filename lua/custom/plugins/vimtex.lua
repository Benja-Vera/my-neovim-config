return {
  'lervag/vimtex',
  lazy = false, -- we don't want to lazy load VimTeX
  version = '*',
  init = function()
    -- VimTeX configuration goes here, e.g.
    vim.g.tex_flavor = 'latex'
    vim.g.vimtex_view_method = 'zathura'
    vim.g.vimtex_imaps_leader = '~'
    vim.g.vimtex_quickfix_autoclose_after_keystrokes = 2

    vim.api.nvim_create_user_command('LatexTemplate', function(opts)
      local args = vim.split(opts.args, ' ')
      vim.fn.system {
        vim.fn.expand '~/.config/nvim/scripts/latex-template.sh',
        args[1],
        args[2],
      }
    end, { nargs = '+' })
  end,
}
