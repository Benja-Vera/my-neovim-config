local M = {}

-- This function follows exactly the contract described in :help complete-functions
--
-- It is called twice:
--   1. findstart = 1  → return the byte column where completion starts
--   2. findstart = 0  → return the completion candidates
--
function M.eqref(findstart, base)

  ---------------------------------------------------------------------------
  -- FIRST INVOCATION: find the start column
  --
  -- Arguments:
  --   findstart == 1
  --   base == "" (always empty here)
  --
  -- We must return:
  --   - a column number (0-based) where replacement starts, OR
  --   - a negative number to cancel completion
  ---------------------------------------------------------------------------
  if findstart == 1 then
    -- Get current line as a Lua string
    local line = vim.api.nvim_get_current_line()

    -- Cursor column (0-based, unlike VimL col('.'))
    local col = vim.api.nvim_win_get_cursor(0)[2]

    -- We only want to complete inside: \eqref{...}
    --
    -- So we take the text BEFORE the cursor and try to match:
    --
    --   \eqref{   <cursor>
    --
    -- The () in the pattern captures the *position* immediately after '{'
    local prefix = line:sub(1, col)
    local start = prefix:match(".*\\eqref%s*{%s*()")

    if start then
      -- Lua string indices are 1-based,
      -- but omnifunc expects a 0-based column.
      return start - 1
    end

    -- Not inside \eqref{...} → cancel completion
    return -1
  end

  ---------------------------------------------------------------------------
  -- SECOND INVOCATION: find completion matches
  --
  -- Arguments:
  --   findstart == 0
  --   base == text between start column and cursor
  --
  -- We must return:
  --   - a List (Lua table) of matches
  --   - or an empty list if nothing matches
  ---------------------------------------------------------------------------

  -- Collect all equation labels in the current buffer
  local labels = {}

  -- Iterate over every line in the buffer
  for _, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, -1, false)) do

    -- Case 1: LaTeX-style labels
    --   \label{eq:something}
    for label in line:gmatch("\\label%s*{%s*([^}]+)%s*}") do
      labels[#labels + 1] = label
    end

    -- Case 2: Quarto-style equation IDs
    --   $$ ... $$ {#eq:something}
    for label in line:gmatch("{#(eq:[^}]+)}") do
      labels[#labels + 1] = label
    end
  end

  -- Filter labels using the "base" prefix
  --
  -- The help says:
  --   "a:base — the text with which matches should match"
  --
  local matches = {}
  local escaped_base = vim.pesc(base)

  for _, lbl in ipairs(labels) do
    if lbl:find("^" .. escaped_base) then
      -- Simple string item → becomes the inserted text
      matches[#matches + 1] = lbl
    end
  end

  -- Return the final list of matches
  return matches
end

return M
