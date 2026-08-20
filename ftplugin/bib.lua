vim.opt_local.spell = true
vim.opt_local.spelllang = { "en" }

local opts = { noremap = true }
vim.keymap.set("n", "j", "gj", opts)
vim.keymap.set("n", "k", "gk", opts)
vim.keymap.set("x", "j", "gj", opts)
vim.keymap.set("x", "k", "gk", opts)
