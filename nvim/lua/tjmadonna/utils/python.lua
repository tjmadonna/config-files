local M = {}

M.find_pyproject = function()
  local path = vim.fn.findfile("pyproject.toml", ".;")
  if path == "" then
    return nil
  end
  return vim.fn.fnamemodify(tostring(path), ":p")
end

M.has_isort_config = function(pyproject_path)
  local file = io.open(pyproject_path, "r")
  if not file then
    return false
  end
  local content = file:read("*a")
  file:close()
  return content:find("%[tool%.isort%]") ~= nil
end

M.has_black_config = function(pyproject_path)
  local file = io.open(pyproject_path, "r")
  if not file then
    return false
  end
  local content = file:read("*a")
  file:close()
  return content:find("%[tool%.black%]") ~= nil
end

M.has_ruff_config = function()
  if vim.fn.findfile("ruff.toml", ".;") ~= "" then
    return true
  end
  if vim.fn.findfile(".ruff.toml", ".;") ~= "" then
    return true
  end

  local pyproject = tostring(vim.fn.findfile("pyproject.toml", ".;"))
  if pyproject ~= "" then
    local file = io.open(vim.fn.fnamemodify(pyproject, ":p"), "r")
    if file then
      local content = file:read("*a")
      file:close()
      if content:find("%[tool%.ruff%]") then
        return true
      end
    end
  end
  return false
end

return M
