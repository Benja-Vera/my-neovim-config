local ls = require("luasnip")

ls.add_snippets("tex", require("snippets.general.common"))
ls.add_snippets("tex", require("snippets.general.operators"))
ls.add_snippets("tex", require("snippets.general.postfix"))
ls.add_snippets("tex", require("snippets.general.common"))
ls.add_snippets("tex", require("snippets.general.fractions"))

vim.cmd.colorscheme("kanagawa-dragon")
vim.opt_local.spell = true
vim.opt_local.spelllang = { "en" }

local opts = { noremap = true }
vim.keymap.set("n", "j", "gj", opts)
vim.keymap.set("n", "k", "gk", opts)
vim.keymap.set("v", "j", "gj", opts)
vim.keymap.set("v", "k", "gk", opts)
vim.keymap.set("s", "j", "j", opts)
vim.keymap.set("s", "k", "k", opts)
