local is_windows = vim.fn.has("win32") == 1
local is_linux = vim.fn.has("unix") == 1 -- This includes macOS and Linux

return {
    "lervag/vimtex",
    lazy = false, -- we don't want to lazy load VimTeX
    version = "*",
    init = function()
        -- VimTeX configuration goes here,
        vim.g.tex_flavor = "latex"
        if is_windows then
            vim.g.vimtex_view_method = "general"
        elseif is_linux then
            vim.g.vimtex_new_method = "zathura"
        end
        vim.g.vimtex_imaps_leader = "~"
        vim.g.vimtex_quickfix_autoclose_after_keystrokes = 2
    end,
}
