-- custom lua line component
local function lsp_names()
  local names = {}
  for _, client in ipairs(vim.lsp.get_active_clients()) do
    print(client.name)
    if client.name ~= '' then
      names[#names + 1] = client.name
    end
  end
  local n = table.concat(names, ', ')
  return n
end

require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "gruvbox_dark",
    component_separators = { left = "|", right = "|" },
    section_separators = { left = " ", right = " " },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { "filename" },
    lualine_x = { "encoding", "fileformat", "lsp_names", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
})
