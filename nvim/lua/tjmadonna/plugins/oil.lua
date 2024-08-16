vim.keymap.set("n", "<leader>e", "<cmd>Oil<cr>", { desc = "Open cwd in oil" })

return {
  "stevearc/oil.nvim",
  event = "VeryLazy",
  opts = {},
  dependencies = { "nvim-tree/nvim-web-devicons" },
}
