-- Latex template command
vim.api.nvim_create_user_command("Template", function(opts)
    local arg = vim.split(opts.args, " ")
    local out = vim.fn.system({
        "python3",
        vim.fn.stdpath("config") .. "/scripts/template.py",
        arg[1],
        arg[2],
    })

    print(out)
end, { nargs = "+" })

-- Command for making the bg transparent
local function set_transparent_bg()
    local groups = { "Normal", "NormalNC", "NonText", "SignColumn", "EndOfBuffer" }
    for _, group in ipairs(groups) do
        vim.api.nvim_set_hl(0, group, { bg = "NONE", ctermbg = "NONE" })
    end
end

vim.api.nvim_create_user_command("Transparent", set_transparent_bg, { desc = "Make background transparent" })
