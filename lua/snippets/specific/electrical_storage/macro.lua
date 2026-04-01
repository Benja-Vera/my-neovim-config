local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local sn = ls.snippet_node

local in_mathzone = function()
    return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

return {
    -- INDICES, SETS, AND TOTALS
    -- DD: \demandnodeset
    s({ trig = "DD", snippetType = "autosnippet", condition = in_mathzone }, {
        t("\\demandnodeset"),
    }),

    -- GD: \dispatchablegennodeset
    s({ trig = "GD", snippetType = "autosnippet", condition = in_mathzone }, {
        t("\\dispatchablegennodeset"),
    }),

    -- GV: \variablegennodeset
    s({ trig = "GV", snippetType = "autosnippet", condition = in_mathzone }, {
        t("\\variablegennodeset"),
    }),

    -- GG: \gennodeset
    s({ trig = "GG", snippetType = "autosnippet", condition = in_mathzone }, {
        t("\\gennodeset"),
    }),

    -- NN: \nodeset
    s({ trig = "NN", snippetType = "autosnippet", condition = in_mathzone }, {
        t("\\nodeset"),
    }),

    -- EE: \edgeset
    s({ trig = "EE", snippetType = "autosnippet", condition = in_mathzone }, {
        t("\\edgeset"),
    }),

    -- TT: \\timeset
    s({ trig = "TT", snippetType = "autosnippet", condition = in_mathzone }, {
        t("\\timeset"),
    }),

    -- KK: \neighbourset
    s({ trig = "KK", snippetType = "autosnippet", condition = in_mathzone }, {
        t("\\neighbourset"),
        c(1, {
            t(""),
            sn(nil, {
                t("["),
                i(1, "\\node"),
                t("]"),
            }),
        }),
    }),

    -- nn -> \node
    s({ trig = "ii", snippetType = "autosnippet", condition = in_mathzone }, {
        t("\\node"),
    }),

    -- ee -> \edge
    s({ trig = "ee", snippetType = "autosnippet", condition = in_mathzone }, {
        t("\\edge"),
    }),

    -- tt -> \time
    s({ trig = "tt", snippetType = "autosnippet", condition = in_mathzone }, {
        t("\\time"),
    }),

    -- NETWORK DATA
    -- sgn: \sgn(\edge, \node)
    s({ trig = "sgn", snippetType = "autosnippet", condition = in_mathzone }, {
        t("\\sgn("),
        i(1, "\\edge"),
        t(", "),
        i(2, "\\node"),
        t(")"),
    }),

    -- rr -> \resistance
    s({ trig = "rr", snippetType = "autosnippet", condition = in_mathzone }, {
        t("\\resistance"),
        c(1, {
            sn(nil, {
                t("["),
                i(1, "\\edge"),
                t("]"),
            }),
        }),
    }),

    -- dd -> \demand
    s({ trig = "dd", snippetType = "autosnippet", condition = in_mathzone }, {
        t("\\demand"),
        c(1, {
            sn(nil, {
                t("["),
                i(1, "\\node"),
                t("]["),
                i(2, "\\time"),
                t("]"),
            }),
        }),
    }),

    -- STATE VARIABLES
    -- qs -> \productionstate
    s({ trig = "qs", snippetType = "autosnippet", condition = in_mathzone }, {
        t("\\productionstate"),
        c(1, {
            sn(nil, {
                t("["),
                i(1, "\\node"),
                t("]["),
                i(2, "\\time"),
                t("]"),
            }),
        }),
    }),

    -- fs -> \flowstate
    s({ trig = "fs", snippetType = "autosnippet", condition = in_mathzone }, {
        t("\\flowstate"),
        c(1, {
            sn(nil, {
                t("["),
                i(1, "\\edge"),
                t("]["),
                i(2, "\\time"),
            }),
        }),
    }),

    -- ss -> \storagestate
    s({ trig = "ss", snippetType = "autosnippet", condition = in_mathzone }, {
        t("\\storagestate"),
        c(1, {
            sn(nil, {
                t("["),
                i(1, "\\node"),
                t("]["),
                i(2, "\\time"),
                t("]"),
            }),
        }),
    }),

    -- RAMP VARIABLES
    -- qr -> \productionramp
    s({ trig = "qr", snippetType = "autosnippet", condition = in_mathzone }, {
        t("\\productionramp"),
        c(1, {
            sn(nil, {
                t("["),
                i(1, "\\node"),
                t("]["),
                i(2, "\\time"),
                t("]"),
            }),
        }),
    }),

    -- fr -> \flowramp
    s({ trig = "fr", snippetType = "autosnippet", condition = in_mathzone }, {
        t("\\flowramp"),
        c(1, {
            sn(nil, {
                t("["),
                i(1, "\\edge"),
                t("]["),
                i(2, "\\time"),
            }),
        }),
    }),

    -- sr -> \storageramp
    s({ trig = "sr", snippetType = "autosnippet", condition = in_mathzone }, {
        t("\\storageramp"),
        c(1, {
            sn(nil, {
                t("["),
                i(1, "\\node"),
                t("]["),
                i(2, "\\time"),
                t("]"),
            }),
        }),
    }),

    -- STATE BOUNDS
    -- qMs: \productionmaxstate
    s({ trig = "qMs", snippetType = "autosnippet", condition = in_mathzone }, {
        t("\\productionmaxstate"),
        c(1, {
            sn(nil, {
                t("["),
                i(1, "\\node"),
                t("]["),
                i(2, "\\time"),
                t("]"),
            }),
        }),
    }),

    -- fMs: \flowmaxstate
    s({ trig = "fMs", snippetType = "autosnippet", condition = in_mathzone }, {
        t("\\flowmaxstate"),
        c(1, {
            sn(nil, {
                t("["),
                i(1, "\\edge"),
                t("]"),
            }),
        }),
    }),

    -- sMs: \storagemaxstate
    s({ trig = "sMs", snippetType = "autosnippet", condition = in_mathzone }, {
        t("\\storagemaxstate"),
        c(1, {
            sn(nil, {
                t("["),
                i(1, "\\edge"),
                t("]"),
            }),
        }),
    }),

    -- RAMP BOUNDS
    -- qMr: \productionmaxramp
    s({ trig = "qMr", snippetType = "autosnippet", condition = in_mathzone }, {
        t("\\productionmaxramp"),
        c(1, {
            sn(nil, {
                t("["),
                i(1, "\\node"),
                t("]"),
            }),
        }),
    }),

    -- qmr: \productionminramp
    s({ trig = "qmr", snippetType = "autosnippet", condition = in_mathzone }, {
        t("\\productionminramp"),
        c(1, {
            sn(nil, {
                t("["),
                i(1, "\\node"),
                t("]"),
            }),
        }),
    }),

    -- fMr: \flowmaxramp
    s({ trig = "fMr", snippetType = "autosnippet", condition = in_mathzone }, {
        t("\\flowmaxramp"),
        c(1, {
            sn(nil, {
                t("["),
                i(1, "\\edge"),
                t("]"),
            }),
        }),
    }),

    -- sMr: \storagemaxramp
    s({ trig = "sMr", snippetType = "autosnippet", condition = in_mathzone }, {
        t("\\storagemaxramp"),
        c(1, {
            sn(nil, {
                t("["),
                i(1, "\\node"),
                t("]"),
            }),
        }),
    }),

    -- smr: \storageminramp
    s({ trig = "smr", snippetType = "autosnippet", condition = in_mathzone }, {
        t("\\storageminramp"),
        c(1, {
            sn(nil, {
                t("["),
                i(1, "\\node"),
                t("]"),
            }),
        }),
    }),

    -- SUMMATIONS
    -- sumt -> \sum_{\time}
    s({ trig = "sumt", snippetType = "autosnippet", condition = in_mathzone }, {
        t("\\sum_{\\time}"),
    }),

    -- sume -> \sum_{\edge \in \neighbourset}
    s({ trig = "sume", snippetType = "autosnippet", condition = in_mathzone }, {
        t("\\sum_{\\edge \\in \\neighbourset}"),
    }),
}
