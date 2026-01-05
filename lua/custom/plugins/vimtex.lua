return {
  'lervag/vimtex',
  lazy = false, -- we don't want to lazy load VimTeX
  version = '*',
  init = function()
    -- VimTeX configuration goes here,
    vim.g.tex_flavor = 'latex'
    vim.g.vimtex_view_method = 'zathura'
    vim.g.vimtex_imaps_leader = '~'
    vim.g.vimtex_quickfix_autoclose_after_keystrokes = 2
  end,
}
