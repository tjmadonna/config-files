local colors = require("tjmadonna.gruvbox")

-- vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = colors.dark0_hard })
-- vim.api.nvim_set_hl(0, "NvimTreeCursorLine", { bg = colors.dark3 })

local HEIGHT_RATIO = 0.8 -- You can change this
local WIDTH_RATIO = 0.3  -- You can change this too

local function title(path)
  -- local cwd = vim.fn.getcwd(0)
  local cwd = path
  local dir = vim.fn.split(cwd, "/")
  return vim.fn.toupper(dir[#dir])
end


local function on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set("n", "<C-c>", api.tree.close, opts("Close"))
  print("nvim-tree: attached to bufnr")
end

require("nvim-tree").setup({
  on_attach = on_attach,
  sort_by = "case_sensitive",
  view = {
    signcolumn = "no",
    float = {
      enable = true,
      open_win_config = function()
        local screen_w = vim.opt.columns:get()
        local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
        local window_w = screen_w * WIDTH_RATIO
        local window_h = screen_h * HEIGHT_RATIO
        local window_w_int = math.floor(window_w)
        local window_h_int = math.floor(window_h)
        local center_x = (screen_w - window_w) / 2
        local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
        return {
          border = "rounded",
          relative = "editor",
          row = center_y,
          col = center_x,
          width = window_w_int,
          height = window_h_int,
        }
      end,
    },
    width = function()
      return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
    end,
  },
  renderer = {
    root_folder_label = title,
    icons = {
      show = {
        file = true,
        folder = false,
        folder_arrow = true,
        git = true,
        modified = true,
      },
    },
  },
  filters = {
    custom = {
      "node_modules",
      ".DS_Store",
      "env",
      "venv",
      ".git",
      "obj",
    },
  },
  git = {
    ignore = false,
  },
})