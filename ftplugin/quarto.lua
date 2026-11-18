vim.treesitter.stop()

local ls = require("luasnip")

vim.keymap.set("n", "<leader>qp", ":QuartoPreview --to all <CR>", {
    noremap = true,
    silent = true,
    desc = "Preview Quarto document",
})

ls.add_snippets("quarto", require("snippets.general.common"))
ls.add_snippets("quarto", require("snippets.general.operators"))
ls.add_snippets("quarto", require("snippets.general.postfix"))
ls.add_snippets("quarto", require("snippets.general.common"))
ls.add_snippets("quarto", require("snippets.general.fractions"))
ls.add_snippets("quarto", require("snippets.specific.quarto_notes.alphabet"))
require("quarto.quarto-math-mappings")()

vim.opt_local.spell = true
vim.opt_local.spelllang = { "es" }

local opts = { noremap = true }
vim.keymap.set("n", "j", "gj", opts)
vim.keymap.set("n", "k", "gk", opts)
vim.keymap.set("x", "j", "gj", opts)
vim.keymap.set("x", "k", "gk", opts)
