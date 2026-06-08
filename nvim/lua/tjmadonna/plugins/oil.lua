vim.keymap.set("n", "<Leader>e", "<Cmd>Oil<CR>", { desc = "Open cwd in oil" })

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
