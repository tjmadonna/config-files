vim.keymap.set("n", "<leader>e", "<cmd>Oil<cr>", { desc = "Open cwd in oil" })

return {
  "stevearc/oil.nvim",
  event = "VeryLazy",
  opts = {
    view_options = {
      show_hidden = true,
    },
  },
  dependencies = { "nvim-tree/nvim-web-devicons" },
}
