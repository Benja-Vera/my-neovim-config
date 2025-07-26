-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  'lervag/vimtex',
  lazy = false, -- we don't want to lazy load VimTeX
  version = '*',
  init = function()
    -- VimTeX configuration goes here, e.g.
    vim.g.tex_flavor = 'latex'
    vim.g.vimtex_view_method = 'general'
    vim.g.vimtex_imaps_leader = '~'
    vim.g.vimtex_quickfix_autoclose_after_keystrokes = 2
  end,
}
