vim.treesitter.stop()

require("quarto.omnifunc")
local ls = require("luasnip")

vim.bo.omnifunc = "v:lua.require'quarto.omnifunc'.eqref"

vim.keymap.set("n", "<leader>qp", ":QuartoPreview<CR>", {
    noremap = true,
    silent = true,
    desc = "Preview Quarto document",
})

ls.add_snippets("quarto", require("snippets.general.common"))
ls.add_snippets("quarto", require("snippets.general.operators"))
ls.add_snippets("quarto", require("snippets.general.postfix"))
ls.add_snippets("quarto", require("snippets.general.common"))
ls.add_snippets("quarto", require("snippets.general.fractions"))
require("quarto.quarto-math-mappings")()

vim.opt_local.spell = true
vim.opt_local.spelllang = { "es" }

local opts = { noremap = true }
vim.keymap.set("n", "j", "gj", opts)
vim.keymap.set("n", "k", "gk", opts)
vim.keymap.set("v", "j", "gj", opts)
vim.keymap.set("v", "k", "gk", opts)
vim.keymap.set("s", "j", "j", opts)
vim.keymap.set("s", "k", "k", opts)
