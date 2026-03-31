local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

-- Math context check using vimtex
local in_mathzone = function()
    return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

M = {
    -- NEW COMMANDS
    -- \newcommand
    s({ trig = "newcommand", wordTrig = true }, {
        t("\\newcommand{"),
        i(1, "\\command"),
        t("}{\\ensuremath{"),
        i(2, "body"),
        t("}}"),
    }),

    -- \NewDocumentCommand{\demand}{O{\node}}{\demandletter_{#1}}
    s({ trig = "newdocumentcommand", wordTrig = true }, {
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
    s({ trig = "dm", wordTrig = true, snippetType = "autosnippet" }, {
        t({ "\\[", "\t" }),
        i(1),
        t({ "", "\\]", "" }),
    }),

    -- THEOREM TYPE ENVIRONMENTS
    -- definition
    s({ trig = "BDEF", wordTrig = true, snippetType = "autosnippet" }, {
        t("\\begin{definition}["),
        i(1, "name of the definition"),
        t({ "]", "\t" }),
        i(2, "body"),
        t({ "", "\\end{definition}", "" }),
        i(0),
    }),

    -- proposition
    s({ trig = "BPROP", wordTrig = true, snippetType = "autosnippet" }, {
        t("\\begin{proposition}["),
        i(1, "name of the proposition"),
        t({ "]", "\t" }),
        i(2, "body"),
        t({ "", "\\end{proposition}", "" }),
        i(0),
    }),

    -- lemma
    s({ trig = "BLEM", wordTrig = true, snippetType = "autosnippet" }, {
        t("\\begin{lemma}["),
        i(1, "name of the lemma"),
        t({ "]", "\t" }),
        i(2, "body"),
        t({ "", "\\end{lemma}", "" }),
        i(0),
    }),

    -- theorem
    s({ trig = "BTHM", wordTrig = true, snippetType = "autosnippet" }, {
        t("\\begin{theorem}["),
        i(1, "name of the theorem"),
        t({ "]", "\t" }),
        i(2, "body"),
        t({ "", "\\end{theorem}", "" }),
        i(0),
    }),

    -- example
    s({ trig = "BEX", wordTrig = true, snippetType = "autosnippet" }, {
        t("\\begin{example}["),
        i(1, "name of the example"),
        t({ "]", "\t" }),
        i(2, "body"),
        t({ "", "\\end{example}", "" }),
        i(0),
    }),

    -- corollary
    s({ trig = "BCOR", wordTrig = true, snippetType = "autosnippet" }, {
        t("\\begin{corollary}["),
        i(1, "name of the corollary"),
        t({ "]", "\t" }),
        i(2, "body"),
        t({ "", "\\end{corollary}", "" }),
        i(0),
    }),

    -- proof
    s({ trig = "BPRF", wordTrig = true, snippetType = "autosnippet" }, {
        t({ "\\begin{proof}", "\t" }),
        i(1, "proof body"),
        t({ "", "\\end{proof}" }),
        i(0),
    }),
}

return M
