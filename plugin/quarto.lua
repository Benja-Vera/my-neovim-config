vim.pack.add({
    { src = "https://github.com/vim-pandoc/vim-pandoc-syntax" },
    { src = "https://github.com/vim-pandoc/vim-pandoc" },
    { src = "https://github.com/quarto-dev/quarto-nvim" },
    { src = "https://github.com/jmbuhr/otter.nvim" },
})
require("quarto").setup({
    lspFeatures = {
        languages = { "python", "julia" },
    },
})
