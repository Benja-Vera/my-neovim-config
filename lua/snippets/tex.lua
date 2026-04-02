local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

-- Math context check using vimtex
local in_mathzone = function()
    return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

-- Check if we are in the beginning of a line
local line_begin = function(line_to_cursor, matched_trigger)
    -- This regex checks if the line consists only of whitespace before the snippet trigger
    return line_to_cursor:sub(1, -(#matched_trigger + 1)):match("^%s*$")
end

M = {
    -- NEW COMMANDS
    -- \newcommand
    s({ trig = "newcommand", wordTrig = true, condition = line_begin }, {
        t("\\newcommand{"),
        i(1, "\\command"),
        t("}{\\ensuremath{"),
        i(2, "body"),
        t("}}"),
    }),

    -- \NewDocumentCommand{\demand}{O{\node}}{\demandletter_{#1}}
    s({ trig = "newdocumentcommand", wordTrig = true, condition = line_begin }, {
        t("\\NewDocumentCommand{"),
        i(1, "\\command"),
        t("}{O{"),
        i(2, "b"),
        t("}}{\\ensuremath{"),
        i(3, "a_{#1}"),
        t("}}"),
    }),
    -- MATH ENVIRONMENTS
    -- inline math
    s({ trig = "mk", wordTrig = true, snippetType = "autosnippet" }, {
        t("\\("),
        i(1),
        t("\\)"),
    }),

    -- display math
    s({ trig = "dm", wordTrig = true, snippetType = "autosnippet", condition = line_begin }, {
        t({ "\\[", "\t" }),
        i(1),
        t({ "", "\\]", "" }),
    }),

    -- align
    s({ trig = "BAL", wordTrig = true, snippetType = "autosnippet", condition = line_begin }, {
        t({ "\\begin{align}", "\t" }),
        i(1),
        t({ "", "\\end{align}", "" }),
    }),

    -- unnumbered align
    s({ trig = "BSAL", wordTrig = true, snippetType = "autosnippet", condition = line_begin }, {
        t({ "\\begin{align*}", "\t" }),
        i(1),
        t({ "", "\\end{align*}", "" }),
    }),

    -- LIST ENVIRONMENTS
    -- itemize
    s({ trig = "BIT", wordTrig = true, snippetType = "autosnippet", condition = line_begin }, {
        t({ "\\begin{itemize}", "\t\\item " }),
        i(1, "text"),
        t({ "", "\\end{itemize}", "" }),
    }),

    -- enumerate
    s({ trig = "BEN", wordTrig = true, snippetType = "autosnippet", condition = line_begin }, {
        t({ "\\begin{enumerate}", "\t\\item " }),
        i(1, "text"),
        t({ "", "\\end{enumerate}", "" }),
    }),

    -- FONT STYLE ENVIRONMENTS
    -- bold
    s({ trig = "FBF", wordTrig = true, snippetType = "autosnippet" }, {
        t("\\textbf{"),
        i(1),
        t("}"),
    }),

    -- italic
    s({ trig = "FIT", wordTrig = true, snippetType = "autosnippet" }, {
        t("\\textit{"),
        i(1),
        t("}"),
    }),

    -- THEOREM TYPE ENVIRONMENTS
    -- definition
    s({ trig = "BDEF", wordTrig = true, snippetType = "autosnippet", condition = line_begin }, {
        t("\\begin{definition}["),
        i(1, "name of the definition"),
        t({ "]", "\t" }),
        i(2, "body"),
        t({ "", "\\end{definition}", "" }),
    }),

    -- proposition
    s({ trig = "BPROP", wordTrig = true, snippetType = "autosnippet", condition = line_begin }, {
        t("\\begin{proposition}["),
        i(1, "name of the proposition"),
        t({ "]", "\t" }),
        i(2, "body"),
        t({ "", "\\end{proposition}", "" }),
    }),

    -- lemma
    s({ trig = "BLEM", wordTrig = true, snippetType = "autosnippet", condition = line_begin }, {
        t("\\begin{lemma}["),
        i(1, "name of the lemma"),
        t({ "]", "\t" }),
        i(2, "body"),
        t({ "", "\\end{lemma}", "" }),
    }),

    -- theorem
    s({ trig = "BTHM", wordTrig = true, snippetType = "autosnippet", condition = line_begin }, {
        t("\\begin{theorem}["),
        i(1, "name of the theorem"),
        t({ "]", "\t" }),
        i(2, "body"),
        t({ "", "\\end{theorem}", "" }),
    }),

    -- remark
    s({ trig = "BRMK", wordTrig = true, snippetType = "autosnippet", condition = line_begin }, {
        t({ "\\begin{remark}", "\t" }),
        i(1, "body"),
        t({ "", "\\end{remark}", "" }),
    }),

    -- example
    s({ trig = "BEX", wordTrig = true, snippetType = "autosnippet", condition = line_begin }, {
        t("\\begin{example}["),
        i(1, "name of the example"),
        t({ "]", "\t" }),
        i(2, "body"),
        t({ "", "\\end{example}", "" }),
    }),

    -- corollary
    s({ trig = "BCOR", wordTrig = true, snippetType = "autosnippet", condition = line_begin }, {
        t("\\begin{corollary}["),
        i(1, "name of the corollary"),
        t({ "]", "\t" }),
        i(2, "body"),
        t({ "", "\\end{corollary}", "" }),
    }),

    -- proof
    s({ trig = "BPRF", wordTrig = true, snippetType = "autosnippet", condition = line_begin }, {
        t({ "\\begin{proof}", "\t" }),
        i(1, "proof body"),
        t({ "", "\\end{proof}" }),
    }),
}

return M
