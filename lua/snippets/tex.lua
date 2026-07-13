local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local d = ls.dynamic_node
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node

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

    -- FONT STYLE COMMANDS
    -- bold
    s({ trig = "FBF", snippetType = "autosnippet" }, {
        t("\\textbf{"),
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
        t("}"),
    }),

    -- italic
    s({ trig = "FIT", snippetType = "autosnippet" }, {
        t("\\textit{"),
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
        t("}"),
    }),

    -- monospaced
    s({ trig = "FTT", snippetType = "autosnippet" }, {
        t("\\texttt{"),
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
        t("}"),
    }),

    -- text color
    s({ trig = "COLOR" }, {
        t("\\textcolor{"),
        c(1, {
            sn(nil, {
                i(1, "ForestGreen"),
                t({ "}{", "\t" }),
                i(2, "body"),
                t({ "", "}", "" }),
            }),
            sn(nil, {
                i(1, "magenta"),
                t({ "}{", "\t" }),
                i(2, "body"),
                t({ "", "}", "" }),
            }),
            sn(nil, {
                i(1, "Blue"),
                t({ "}{", "\t" }),
                i(2, "body"),
                t({ "", "}", "" }),
            }),
            sn(nil, {
                i(1, "Turquoise"),
                t({ "}{", "\t" }),
                i(2, "body"),
                t({ "", "}", "" }),
            }),
        }),
    }),

    -- center
    s({ trig = "BCEN", wordTrig = true, snippetType = "autosnippet", condition = line_begin }, {
        t({ "\\begin{center}", "\t" }),
        i(1),
        t({ "", "\\end{center}", "" }),
    }),

    -- frame
    s({ trig = "BFR", snippetType = "autosnippet" }, {
        t("\\begin{frame}"),
        d(1, function(args, parent)
            local env = parent.snippet.env
            if #env.LS_SELECT_RAW > 0 then
                -- If text is selected, return the selection
                return sn(nil, {
                    t({ "", "\t" }),
                    t(env.LS_SELECT_RAW),
                })
            else
                -- Otherwise, provide an empty insert node
                return sn(nil, {
                    t("\t\\frametitle{"),
                    i(1, "title of the frame"),
                    i(2, "body"),
                })
            end
        end, {}),
        t({ "", "", "\\end{frame}", "" }),
    }),

    -- verbatim: code block
    s({ trig = "BVER", wordTrig = true, snippetType = "autosnippet", condition = line_begin }, {
        t({ "\\begin{verbatim}", "" }),
        i(1),
        t({ "", "\\end{verbatim}", "" }),
    }),

    -- figure
    s({ trig = "BFI", wordTrig = true, snippetType = "autosnippet", condition = line_begin }, {
        t("\\begin{figure}["),
        i(1, "htbp"),
        t({ "]", "\t\\centering", "\t\\includegraphics[width=" }),
        i(3, "0.5"),
        t("\\linewidth]{"),
        i(2, "path/to/image.pdf"),
        t({ "}", "" }),
        t("\t\\caption{"),
        i(4, "Caption here."),
        t({ "}", "\t\\label{fig:" }),
        i(5, "label"),
        t({ "}", "\\end{figure}", "" }),
    }),

    -- subfigures
    s({ trig = "BMFI", wordTrig = true, snippetType = "autosnippet", condition = line_begin }, {
        t("\\begin{figure}["),
        i(1, "htbp"),
        t({ "]", "", "\\begin{subfigure}{0.5\\textwidth}", "\\includegraphics[width=0.9\\linewidth]{" }),
        i(2, "path/to/image.pdf"),
        t({ "}", "\\caption{" }),
        i(3, "Some text here."),
        t({ "}", "\\label{fig:" }),
        i(4, "label-1"),
        t({ "}", "\\end{subfigure}", "\\begin{subfigure}{0.5\\textwidth}", "\\includegraphics[width=0.9\\linewidth]{" }),
        i(5, "path/to/image.pdf"),
        t({ "}", "\\caption{" }),
        i(6, "Some text here."),
        t({ "}", "\\label{fig:" }),
        i(7, "label-2"),
        t({ "}", "\\end{subfigure}", "", "\\caption{" }),
        i(8, "Caption for the whole figure here."),
        t({ "}", "\\label{fig:" }),
        i(9, "label"),
        t({ "}", "\\end{figure}" }),
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

    -- numbered equation
    s({
        trig = "BEQ",
        wordTrig = true,
        snippetType = "autosnippet",
        condition = line_begin,
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

    -- unnumbered equation
    s({ trig = "BSEQ", wordTrig = true, snippetType = "autosnippet", condition = line_begin }, {
        t({ "\\begin{equation*}", "\t" }),
        i(1, "body"),
        t({ "", "\\end{equation*}", "" }),
    }),

    -- subequations
    s({ trig = "BSE", wordTrig = true, condition = line_begin }, {
        t({ "\\begin{subequations}", "" }),
        i(1),
        t({ "", "\\end{subequations}", "" }),
    }),

    -- numbered gather
    s({ trig = "BGA", wordTrig = true, snippetType = "autosnippet", condition = line_begin }, {
        t({ "\\begin{gather}", "\t" }),
        i(1),
        t({ "", "\\end{gather}", "" }),
    }),

    -- unnumbered gather
    s({ trig = "BSGA", wordTrig = true, snippetType = "autosnippet", condition = line_begin }, {
        t({ "\\begin{gather*}", "\t" }),
        i(1),
        t({ "", "\\end{gather*}", "" }),
    }),

    -- numbered align
    s({ trig = "BAL", wordTrig = true, snippetType = "autosnippet", condition = line_begin }, {
        t({ "\\begin{align} \\label{eq:" }),
        i(1, "label"),
        t({ "}", "" }),
        i(2, "body"),
        t({ "", "\\end{align}", "" }),
    }),

    -- unnumbered align
    s({ trig = "BSAL", wordTrig = true, snippetType = "autosnippet", condition = line_begin }, {
        t({ "\\begin{align*}", "\t" }),
        i(1),
        t({ "", "\\end{align*}", "" }),
    }),

    -- cases
    s({
        trig = "BCAS",
        wordTrig = true,
        snippetType = "autosnippet",
        condition = line_begin,
    }, {
        t({ "\\begin{cases}", "\t" }),
        i(1),
        t({ "", "\\end{cases}", "" }),
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
}

return M
