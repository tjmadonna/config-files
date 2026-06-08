return {
  "nvim-telescope/telescope.nvim",
  event = "VeryLazy",
  tag = "v0.2.1",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local builtin = require("telescope.builtin")

    telescope.setup({
      defaults = {
        path_display = { "truncate" },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send to quickfix
            ["<C-x>"] = actions.send_to_qflist + actions.open_qflist, -- send all to quickfix
          },
        },
      },
    })

    telescope.load_extension("fzf")

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<Leader>ff", "<Cmd>Telescope find_files hidden=true<CR>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<Leader>fr", "<Cmd>Telescope oldfiles<CR>", { desc = "Fuzzy find recent files" })
    keymap.set("n", "<Leader>fs", "<Cmd>Telescope live_grep<CR>", { desc = "Find string in cwd" })
    keymap.set("n", "<Leader>fc", "<Cmd>Telescope grep_string<CR>", { desc = "Find string under cursor in cwd" })
    keymap.set("n", "<Leader>fm", "<Cmd>Telescope marks<CR>", { desc = "Find current marks" })
    keymap.set("n", "<Leader>fb", "<Cmd>Telescope buffers<CR>", { desc = "Find an open buffer" })
    keymap.set("n", "<Leader>fd", "<Cmd>Telescope diagnostics<CR>", { desc = "Find diagnostics in open buffers" })

    vim.keymap.set("n", "<Leader>fg", function()
      builtin.grep_string({ search = vim.fn.input("Grep > ") })
    end, { desc = "Grep string in cwd" })
  end,
}
