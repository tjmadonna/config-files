local M = {}

-- Normalize vim.g value to a table (handles both string and table)
local function to_list(value)
  if type(value) == "string" then
    return { value }
  elseif type(value) == "table" then
    return value
  end
  return nil
end

-- Returns allowed tools for a filetype global, filtered against a candidates list.
-- If the global is not set, returns empty table.
-- e.g. get_tools("python_linters", { "ruff", "flake8" })
M.get_tools = function(key, candidates)
  local global = vim.g[key]
  if global == nil then
    return {}
  end

  local allowed = to_list(global)
  if allowed == nil then
    return {}
  end

  return vim.tbl_filter(function(c)
    return vim.tbl_contains(allowed, c)
  end, candidates)
end

return M
