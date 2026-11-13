local TEMPLATE = {
  "vim.g.tools = {",
  "  formatters = {",
  '    python = { "isort", "black" },',
  '    lua = "stylua",',
  '    javascript = "prettier",',
  "  },",
  "  linters = {",
  '    python = { "flake8" },',
  "  },",
  "}",
}

vim.api.nvim_create_user_command("ToolsInit", function()
  local path = vim.fn.getcwd() .. "/.nvim.lua"

  if vim.fn.filereadable(path) == 1 then
    vim.notify(".nvim.lua already exists in " .. vim.fn.getcwd(), vim.log.levels.WARN)
    return
  end

  if vim.fn.writefile(TEMPLATE, path) == -1 then
    vim.notify("Could not write " .. path, vim.log.levels.ERROR)
    return
  end

  vim.notify("Created " .. path)
  vim.cmd("edit " .. vim.fn.fnameescape(path))
end, { desc = "Create a project-local .nvim.lua with a tools template" })
