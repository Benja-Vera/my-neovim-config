--- @module 'blink.cmp'
--- @class blink.cmp.Source
local source = {}

function source.new(opts)
    local self = setmetatable({}, { __index = source })
    self.opts = opts
    return self
end

-- Only enable in Quarto documents
function source:enabled()
    return vim.bo.filetype == "quarto"
end

-- Trigger after opening a brace
function source:get_trigger_characters()
    return { "{" }
end

function source:get_completions(ctx, callback)
    -- Get cursor position and current line
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local line = vim.api.nvim_get_current_line()
    local before_cursor = line:sub(1, col)

    -- Check whether we're inside an \eqref{...} argument
    local _, open_end = before_cursor:find(".*\\eqref%s*{")

    if not open_end then
        callback({ items = {} })
        return
    end

    -- Don't complete if the argument is already closed
    local argument = before_cursor:sub(open_end + 1)

    if argument:find("}") then
        callback({ items = {} })
        return
    end

    -- Read the entire buffer
    local lines = vim.api.nvim_buf_get_lines(ctx.bufnr, 0, -1, false)
    local text = table.concat(lines, "\n")

    -- Extract all \label{...} contents
    local labels = {}

    for label in text:gmatch("\\label%s*{([^}]+)}") do
        table.insert(labels, label)
    end

    -- Create completion items
    local items = {}

    for _, label in ipairs(labels) do
        table.insert(items, {
            label = label,
            kind = require("blink.cmp.types").CompletionItemKind.Text,

            textEdit = {
                newText = label,
                range = {
                    start = {
                        line = row - 1,
                        character = open_end,
                    },
                    ["end"] = {
                        line = row - 1,
                        character = col,
                    },
                },
            },

            insertTextFormat = vim.lsp.protocol.InsertTextFormat.PlainText,
        })
    end

    callback({
        items = items,
        is_incomplete_backward = false,
        is_incomplete_forward = false,
    })
end

return source
