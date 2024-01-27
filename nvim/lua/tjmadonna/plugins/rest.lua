return {
  "rest-nvim/rest.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  event = "VeryLazy",
  config = function()
    local rest = require("rest-nvim")
    rest.setup()

    -- set keymaps
    vim.keymap.set("n", "<leader>rr", "<Plug>RestNvim<CR>", { desc = "Run RestNvim request under cursor" })
  end,
}
