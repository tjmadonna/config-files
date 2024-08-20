vim.keymap.set("n", "<leader>cp", "<cmd>CopilotChatOpen<cr>", { desc = "Open Copilot Chat buffer" })

return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    event = "InsertEnter",
    tag = "v2.13.0",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    opts = {
      debug = false, -- Enable debugging
    },
  },
}
