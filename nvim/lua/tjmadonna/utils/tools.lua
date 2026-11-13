local M = {}

-- Normalize a value to a table (handles both string and table)
-- @param value string|table The value to normalize
-- @return table|nil The normalized value as a table
local function to_list(value)
  if type(value) == "string" then
    return { value }
  elseif type(value) == "table" then
    return value
  end
  return nil
end

---Returns the candidates enabled in vim.g.tools[kind][ft], in candidate order.
---@param kind "formatters"|"linters" Which group in vim.g.tools to read
---@param ft string Filetype, e.g. "python"
---@param candidates string[] Tools this plugin config knows how to run
---@return string[] tools Enabled tools; empty if nothing is configured
M.get_tools = function(kind, ft, candidates)
  local group = vim.g.tools and vim.g.tools[kind]
  if type(group) ~= "table" then
    return {}
  end

  local allowed = to_list(group[ft])
  if allowed == nil then
    return {}
  end

  return vim.tbl_filter(function(c)
    return vim.tbl_contains(allowed, c)
  end, candidates)
end

return M
