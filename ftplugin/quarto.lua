require("custom.quarto.omnifunc")
local ls = require("luasnip")

vim.bo.omnifunc = "v:lua.require'custom.quarto.omnifunc'.eqref"

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
require("mappings.quarto-math-mappings")()

vim.cmd.colorscheme("kanagawa-dragon")
vim.opt_local.spell = true
vim.opt_local.spelllang = { "es" }

local opts = { noremap = true }
vim.keymap.set("n", "j", "gj", opts)
vim.keymap.set("n", "k", "gk", opts)
vim.keymap.set("v", "j", "gj", opts)
vim.keymap.set("v", "k", "gk", opts)
vim.keymap.set("s", "j", "j", opts)
vim.keymap.set("s", "k", "k", opts)

local function toggle_surrounding_delimiters()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local line = vim.api.nvim_get_current_line()
    col = col + 1 -- Lua string index

    local patterns = {
        { plain = { "(", ")" }, latex = { "\\left(", "\\right)" }, symbol = "()" },
        { plain = { "[", "]" }, latex = { "\\left[", "\\right]" }, symbol = "[]" },
        { plain = { "{", "}" }, latex = { "\\left\\{", "\\right\\}" }, symbol = "{}" },
    }

    for _, pair in ipairs(patterns) do
        -- Look for LaTeX-style delimiters first
        local latex_start_pat = vim.pesc(pair.latex[1])
        local latex_end_pat = vim.pesc(pair.latex[2])

        local s, e = line:find(latex_start_pat .. "(.-)" .. latex_end_pat)
        if s and e and s <= col and col <= e then
            local inner = line:sub(s + #pair.latex[1], e - #pair.latex[2])
            local new_line = line:sub(1, s - 1) .. pair.plain[1] .. inner .. pair.plain[2] .. line:sub(e + 1)
            local new_col = s + math.min(col - s - #pair.latex[1] + 1, #inner)
            vim.api.nvim_set_current_line(new_line)
            vim.api.nvim_win_set_cursor(0, { row, new_col - 1 })
            return
        end

        -- Find all balanced pairs using a stack to track nesting
        local opener = pair.plain[1]
        local closer = pair.plain[2]
        local stack = {}
        local innermost = nil

        for i = 1, #line do
            local char = line:sub(i, i)
            if char == opener then
                table.insert(stack, i)
            elseif char == closer and #stack > 0 then
                local start_pos = table.remove(stack)
                local end_pos = i
                if start_pos <= col and col <= end_pos then
                    -- Choose the smallest enclosing (innermost) match
                    if not innermost or (end_pos - start_pos) < (innermost[2] - innermost[1]) then
                        innermost = { start_pos, end_pos }
                    end
                end
            end
        end

        if innermost then
            local s, e = unpack(innermost)
            local inner = line:sub(s + 1, e - 1)
            local new_line = line:sub(1, s - 1) .. pair.latex[1] .. inner .. pair.latex[2] .. line:sub(e + 1)
            local new_col = s + #pair.latex[1] + math.min(col - s - 1, #inner)
            vim.api.nvim_set_current_line(new_line)
            vim.api.nvim_win_set_cursor(0, { row, new_col - 1 })
            return
        end
    end
end

vim.keymap.set("n", "tsd", toggle_surrounding_delimiters, { buffer = true, desc = "Toggle LaTeX-style delimiters" })
