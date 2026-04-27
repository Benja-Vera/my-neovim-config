-- vim.cmd.colorscheme("kanagawa-dragon")
vim.opt_local.spell = true
vim.opt_local.spelllang = { "en", "fr" }

local opts = { noremap = true }
vim.keymap.set("n", "j", "gj", opts)
vim.keymap.set("n", "k", "gk", opts)
vim.keymap.set("v", "j", "gj", opts)
vim.keymap.set("v", "k", "gk", opts)
vim.keymap.set("s", "j", "j", opts)
vim.keymap.set("s", "k", "k", opts)
