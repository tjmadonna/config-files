return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local gitsigns = require("gitsigns")
    gitsigns.setup()

    -- set keybinds
    local keymap = vim.keymap -- for conciseness
    local opts = { noremap = true, silent = true }

    opts.desc = "Git Blame Line"
    keymap.set("n", "<leader>gb", "<Cmd>Gitsigns blame_line<CR>", opts)

    opts.desc = "Git Diff"
    keymap.set("n", "<leader>gd", "<Cmd>Gitsigns diffthis<CR>", opts)

    opts.desc = "Git Stage Hunk"
    keymap.set("v", "<leader>gs", function()
      gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, opts)

    opts.desc = "Git Unstage Hunk"
    keymap.set("v", "<leader>gu", function()
      gitsigns.undo_stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, opts)

    opts.desc = "Git Stage Buffer"
    keymap.set("n", "<leader>gS", function()
      gitsigns.stage_buffer()
    end, opts)
  end,
}
