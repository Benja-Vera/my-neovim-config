local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local d = ls.dynamic_node
local sn = ls.snippet_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

-- Math context check using vimtex
local in_mathzone = function()
    return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

M = {
    -- FONT
    -- italic
    s({ trig = "FIT", snippetType = "autosnippet" }, {
        t("*"),
        d(1, function(args, parent)
            local env = parent.snippet.env
            if #env.LS_SELECT_RAW > 0 then
                -- If text is selected, return the selection
                return sn(nil, {
                    t(env.LS_SELECT_RAW),
                })
            else
                -- Otherwise, provide an empty insert node
                return sn(nil, {
                    i(1),
                })
            end
        end, {}),
        t("* "),
    }),

    -- bold
    s("bold", {
        t("**"),
        d(1, function(args, parent)
            local env = parent.snippet.env
            if #env.LS_SELECT_RAW > 0 then
                -- If text is selected, return the selection
                return sn(nil, {
                    t(env.LS_SELECT_RAW),
                })
            else
                -- Otherwise, provide an empty insert node
                return sn(nil, {
                    i(1),
                })
            end
        end, {}),
        t("** "),
    }),

    -- code
    s("inline-code", {
        t("`"),
        i(1, "text"),
        t("`"),
    }),

    -- BLOCKS
    -- executable code block
    s("executable-codeblock", {
        t("```{"),
        i(1, "lang"),
        t({ "}", "#| code-fold: true", "" }),
        i(2, "code"),
        t({ "", "```", "" }),
    }),

    -- definition
    s(
        "def",
        fmt(
            [[
    ::: {{#def-{}}}
    {}

    {}
    :::


  ]],
            {
                i(1, "label"),
                c(2, {
                    fmt("## {}\n", i(1, "name")), -- Option: name line
                    t(""), -- Option: no name line
                }),
                i(3, "body"),
            }
        )
    ),
    -- problem + solution
    s(
        "exr",
        fmt(
            [[
    ::: {{#exr-{}}}
    {}

    {}
    :::

    ::: {{.callout collapse=true}}
    ## Solución

    {}
    :::


    ]],
            {
                i(1, "label"), -- label only for the exercise
                c(2, {
                    fmt("## {}\n", i(1, "Exercise Title")), -- optional title
                    t(""), -- no title
                }),
                i(3, "Problem body"),
                i(4, "Solution body"),
            }
        )
    ),
    -- solution
    s({
        trig = "solucion",
    }, {
        t({
            "::: {.callout collapse=true}",
            "## Solución",
            "",
        }),
        i(1),
        t({
            "",
            ":::",
            "",
            "",
        }),
    }),
    -- Hoja de ruta
    s({
        trig = "hoja-de-ruta",
    }, {
        t({
            "::: {.callout-tip}",
            "## Hoja de ruta",
            "",
            "",
        }),
        i(1),
        t({
            "",
            ":::",
            "",
            "",
        }),
    }),
    -- Conclusión
    s({
        trig = "conclusión",
    }, {
        t({
            "::: {.callout-tip icon=false}",
            "## Conclusión",
            "",
            "",
        }),
        i(1),
        t({
            "",
            ":::",
            "",
            "",
        }),
    }),

    -- DIFFERENTIAL OPERATORS
    -- Derivative: d f / d x
    s({
        trig = "DV",
        snippetType = "autosnippet",
        condition = in_mathzone,
        show_condition = in_mathzone,
    }, {
        t("\\frac{\\mathrm{d} "),
        i(1, "f"),
        t("}{\\mathrm{d} "),
        i(2, "x"),
        t("}"),
    }),

    -- Partial derivative: ∂ f / ∂ x
    s({
        trig = "PDV",
        snippetType = "autosnippet",
        condition = in_mathzone,
        show_condition = in_mathzone,
    }, {
        t("\\frac{\\partial "),
        i(1, "f"),
        t("}{\\partial "),
        i(2, "x"),
        t("}"),
    }),

    -- Higher order derivative: d^n f / d x^n
    s({
        trig = "DVN",
        snippetType = "autosnippet",
        condition = in_mathzone,
        show_condition = in_mathzone,
    }, {
        t("\\frac{\\mathrm{d}^{"),
        i(1, "n"),
        t("} "),
        i(2, "f"),
        t("}{\\mathrm{d} "),
        i(3, "x"),
        t("^{"),
        rep(1),
        t("}}"),
    }),

    -- Higher order partial derivative: ∂^n f / ∂ x^n
    s({
        trig = "PDVN",
        snippetType = "autosnippet",
        condition = in_mathzone,
        show_condition = in_mathzone,
    }, {
        t("\\frac{\\partial^{"),
        i(1, "n"),
        t("} "),
        i(2, "f"),
        t("}{\\partial "),
        i(3, "x"),
        t("^{"),
        rep(1),
        t("}}"),
    }),

    -- ENVIRONMENTS
    -- bracket matrix
    s({
        trig = "BMAT",
        snippetType = "autosnippet",
        condition = in_mathzone,
        show_condition = in_mathzone,
    }, {
        t({ "\\begin{bmatrix}", "" }),
        i(1),
        t({ "", "\\end{bmatrix}" }),
    }),

    -- parentheses matrix
    s({
        trig = "PMAT",
        snippetType = "autosnippet",
        condition = in_mathzone,
        show_condition = in_mathzone,
    }, {
        t({ "\\begin{pmatrix}", "" }),
        i(1),
        t({ "", "\\end{pmatrix}" }),
    }),

    -- determinant matrix
    s({
        trig = "VMAT",
        snippetType = "autosnippet",
        condition = in_mathzone,
        show_condition = in_mathzone,
    }, {
        t({ "\\begin{vmatrix}", "" }),
        i(1),
        t({ "", "\\end{vmatrix}" }),
    }),

    -- GEN -> \langle #1 \rangle #2
    s({
        trig = "GEN",
        snippetType = "autosnippet",
        condition = in_mathzone,
        show_condition = in_mathzone,
    }, {
        t("\\langle "),
        i(1),
        t(" \\rangle "),
        i(0),
    }),

    -- DPROD -> \langle #1, #2 \rangle #3
    s({
        trig = "DPROD",
        snippetType = "autosnippet",
        condition = in_mathzone,
        show_condition = in_mathzone,
    }, {
        t("\\langle "),
        i(1),
        t(", "),
        i(2),
        t(" \\rangle "),
        i(0),
    }),

    -- MATH ENVIRONMENTS
    -- inline math
    s({ trig = "mk", wordTrig = true, snippetType = "autosnippet" }, {
        t("$"),
        i(1),
        t("$"),
    }),

    -- display math
    s({ trig = "dm", wordTrig = true, snippetType = "autosnippet" }, {
        t({ "$$", "\t" }),
        i(1),
        t({ "", "$$", "" }),
    }),

    -- numbered equation
    s({
        trig = "BEQ",
        snippetType = "autosnippet",
        condition = in_mathzone,
        show_condition = in_mathzone,
    }, {
        t({ "\\begin{equation} \\label{eq:" }),
        i(1, "label"),
        t({ "}", "\t" }),
        i(2, "body"),
        c(3, {
            sn(nil, {
                t(" . \\tag{"),
                i(1, "TAG"),
                t("}"),
            }),
            t(" ."),
        }),
        t({ "", "\\end{equation}" }),
    }),

    -- subequations
    s({
        trig = "BSE",
        wordTrig = true,
        condition = in_mathzone,
        show_condition = in_mathzone,
    }, {
        t({ "\\begin{subequations}", "" }),
        i(1),
        t({ "", "\\end{subequations}", "" }),
    }),

    -- gather
    s({
        trig = "BGA",
        wordTrig = true,
        snippetType = "autosnippet",
        condition = in_mathzone,
        show_condition = in_mathzone,
    }, {
        t({ "\\begin{gather}", "\t" }),
        i(1),
        t({ "", "\\end{gather}", "" }),
    }),

    -- unnumbered gather
    s({
        trig = "BSGA",
        wordTrig = true,
        snippetType = "autosnippet",
        condition = in_mathzone,
        show_condition = in_mathzone,
    }, {
        t({ "\\begin{gather*}", "\t" }),
        i(1),
        t({ "", "\\end{gather*}", "" }),
    }),

    -- numbered align
    s({
        trig = "BAL",
        snippetType = "autosnippet",
        condition = in_mathzone,
        show_condition = in_mathzone,
    }, {
        t({ "\\begin{align} \\label{eq:" }),
        i(1, "label"),
        t({ "}", "" }),
        i(2, "body"),
        t({ "", "\\end{align}", "" }),
    }),

    -- unnumbered align
    s({
        trig = "BSAL",
        snippetType = "autosnippet",
        condition = in_mathzone,
        show_condition = in_mathzone,
    }, {
        t({ "\\begin{align*}", "" }),
        i(1),
        t({ "", "\\end{align*}", "" }),
    }),

    -- array
    s({
        trig = "BAR",
        snippetType = "autosnippet",
        condition = in_mathzone,
        show_condition = in_mathzone,
    }, {
        t({ "\\begin{array}{c}", "" }),
        i(1),
        t({ "", "\\end{array}" }),
    }),

    -- cases
    s({
        trig = "BCAS",
        snippetType = "autosnippet",
        condition = in_mathzone,
        show_condition = in_mathzone,
    }, {
        t({ "\\begin{cases}", "\t" }),
        i(1),
        t({ "", "\\end{cases}", "" }),
    }),
}

return M
