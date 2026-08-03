local ls = require("luasnip")

ls.add_snippets("tex", require("snippets.general.common"))
ls.add_snippets("tex", require("snippets.general.operators"))
ls.add_snippets("tex", require("snippets.general.postfix"))
ls.add_snippets("tex", require("snippets.general.common"))
ls.add_snippets("tex", require("snippets.general.fractions"))

vim.opt_local.spell = true
vim.opt_local.spelllang = { "en" }

local opts = { noremap = true }
vim.keymap.set("n", "j", "gj", opts)
vim.keymap.set("n", "k", "gk", opts)
vim.keymap.set("x", "j", "gj", opts)
vim.keymap.set("x", "k", "gk", opts)

vim.cmd.colorscheme("candyland")
