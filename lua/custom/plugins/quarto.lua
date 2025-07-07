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
    end,
  },
}
